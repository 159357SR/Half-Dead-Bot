extends Label

@onready var drain_timer = $Timer

var current_charge = 90

func _ready():
	text = "Charge: " + str(current_charge)
	
	match Global.difficulty:
		"easy":
			drain_timer.wait_time = 0.9
		"normal":
			drain_timer.wait_time = 0.4
		"hard":
			drain_timer.wait_time = 0.25
		"extreme":
			drain_timer.wait_time = 0.17

func _on_timer_timeout():
	if not Global.is_infinite_active:
		current_charge -= 1
	if current_charge <= 0:
		Global.check_unlocks()
		Global.check_and_save_score()
		Global.death_message = "OUT OF CHARGE"
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
	else:
		text = "Charge: " + str(current_charge)

func add_power():
	var charge_amount = 10
	match Global.difficulty:
		"easy":
			charge_amount = 10
		"normal":
			charge_amount = 10
		"hard":
			charge_amount = 15
		"extreme":
			charge_amount = 20
			
	current_charge += charge_amount
	if current_charge > 100:
		current_charge = 100
	text = "Charge: " + str(current_charge)

func add_super_power():
	var charge_amount = 20
	match Global.difficulty:
		"easy":
			charge_amount = 20
		"normal":
			charge_amount = 20
		"hard":
			charge_amount = 25
		"extreme":
			charge_amount = 50
			
	current_charge += charge_amount
	if current_charge > 100:
		current_charge = 100
	text = "Charge: " + str(current_charge)
