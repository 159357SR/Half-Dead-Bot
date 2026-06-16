extends Area2D
func _ready():
	move_to_random_position()

func _on_area_entered(area):
	if area.name == "Player":
		get_parent().get_node("ScoreLabel").add_point()
		get_parent().get_node("ChargeLabel").add_power()
		get_parent().get_node("CoinSound").play()
		move_to_random_position()

func move_to_random_position():
	var screen_size = get_viewport_rect().size
	var random_x = randf_range(15,screen_size.x - 50)
	var random_y = randf_range(64,screen_size.y - 50)
	position = Vector2(random_x,random_y)
