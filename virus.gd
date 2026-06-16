extends Area2D

var speed: float = 80.0
var player = null
var target_offset = Vector2.ZERO

func _ready():
	player = get_parent().get_node("Player")
	speed += randf_range(-15.0, 15.0)
	target_offset = Vector2(randf_range(-37, 37), randf_range(-37, 37))

func _process(delta):
	if player != null and not Global.is_freeze_active:
		var direction = global_position.direction_to(player.global_position + target_offset)
		position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		Global.check_and_save_score()
		Global.death_message = "SYSTEM INFECTION: CAUGHT BY VIRUS"
		get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")
