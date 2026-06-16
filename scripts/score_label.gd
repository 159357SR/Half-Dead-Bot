extends Label

@onready var super_charge: Area2D = $"../SuperCharge"


var current_score = 0

func _ready():
	current_score = 0
	Global.final_score = 0
	text = "Score: " + str(current_score)

func add_point():
	current_score += 1
	Global.final_score = current_score
	text = "Score: " + str(current_score)
	if current_score % 10 == 0:
		super_charge.spawn_supercharge()
