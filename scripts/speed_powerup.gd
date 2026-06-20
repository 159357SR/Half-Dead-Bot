extends Area2D

@onready var despawn_timer = $DespawnTimer
@onready var active_timer = $ActiveTimer

# Ensure you have a TextureProgressBar named exactly "SpeedClock" inside your UILayer!
@onready var ui_clock = $"../UILayer/SpeedClock" 

var screen_size
var last_spawn_score = 0
var score_gap = 20
var speed_time = 10

func _ready():
	screen_size = get_viewport_rect().size
	position.y = -1000
	if ui_clock: 
		ui_clock.hide()
	
	despawn_timer.one_shot = true
	active_timer.one_shot = true

	match Global.difficulty:
		"easy": score_gap = 17
		"normal": score_gap = 13
		"hard": score_gap = 10
		"extreme": score_gap = 7

func _process(_delta):
	if not active_timer.is_stopped() and ui_clock:
		ui_clock.value = (active_timer.time_left / active_timer.wait_time) * 100

	# Spawn condition based on score collection
	if Global.final_score >= last_spawn_score + score_gap:
		if not Global.is_speed_active and position.y == -1000:
			spawn_powerup()

func spawn_powerup():
	position.x = randf_range(50, screen_size.x - 50)
	position.y = randf_range(50, screen_size.y - 50)
	despawn_timer.start(10.0)

func _on_despawn_timer_timeout():
	position.y = -1000
	last_spawn_score = Global.final_score 

func _on_area_entered(area):
	if area.is_in_group("Player"):
		position.y = -1000
		despawn_timer.stop()
		
		var current_speed_time = speed_time
		
		if Global.equipped_avatar == "ardor":
			current_speed_time *= 1.3
			print("Ardor's Ability Used!!!")
		
		Global.is_speed_active = true
		if ui_clock: 
			ui_clock.show()
		active_timer.start(current_speed_time)

func _on_active_timer_timeout():
	Global.is_speed_active = false
	if ui_clock: 
		ui_clock.hide()
	last_spawn_score = Global.final_score
