extends Area2D

@onready var score_label: Label = $"../ScoreLabel"
@onready var timer: Timer = $Timer
@onready var charge_label: Label = $"../ChargeLabel"

func _ready():
	position.y = -1000

func spawn_supercharge():
	position.x = randf_range(100, 400)
	position.y = randf_range(100, 480)
	timer.start()

func _on_timer_timeout() -> void:
	position.y = -1000

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		charge_label.add_super_power()
		get_parent().get_node("SuperChargeSound").play()
		position.y = -1000
		timer.stop()
