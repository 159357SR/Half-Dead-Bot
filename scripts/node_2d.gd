extends Node2D

var bug_scene = preload("res://scenes/virus.tscn")
@onready var pause_menu = $UILayer/pause_menu

func _ready():
	spawn_player()
	Global.current_run_time = 0.0
	Global.is_playing = true
	Global.is_speed_active = false
	Global.is_freeze_active = false
	Global.is_infinite_active = false
	
	var bug_speeds = []
	
	match Global.difficulty:
		"easy":
			bug_speeds = [80, 90]
		"normal":
			bug_speeds = [90, 110]
		"hard":
			bug_speeds = [120, 100, 110]
		"extreme":
			bug_speeds = [130, 140, 150, 110, 115]
			
	for current_speed in bug_speeds:
		spawn_bug(current_speed)

func spawn_player():
	var current_bot_id = Global.equipped_avatar
	var bot_data = Global.avatars[current_bot_id]
	var bot_path = Global.avatars[current_bot_id]["scene_path"]
	var bot_scene = load(bot_path)
	var bot_instance = bot_scene.instantiate()
	if bot_data["name"] == "Aero":
		bot_instance.speed *= 1.20
		print("Speed boosted by 20%")
	bot_instance.global_position = Vector2(500, 300) 
	add_child(bot_instance)

func spawn_bug(starting_speed):
	var new_bug = bug_scene.instantiate()
	new_bug.speed = starting_speed
	
	var screen_size = get_viewport_rect().size
	var spawn_pos = Vector2.ZERO
	var margin = 100
	
	var random_edge = randi() % 4
	
	if random_edge == 0:
		spawn_pos.x = randf_range(0, screen_size.x)
		spawn_pos.y = -margin
	elif random_edge == 1:
		spawn_pos.x = randf_range(0, screen_size.x)
		spawn_pos.y = screen_size.y + margin
	elif random_edge == 2:
		spawn_pos.x = -margin
		spawn_pos.y = randf_range(0, screen_size.y)
	elif random_edge == 3:
		spawn_pos.x = screen_size.x + margin
		spawn_pos.y = randf_range(0, screen_size.y)
		
	new_bug.position = spawn_pos
	
	var color_list = [Color.GREEN, Color.YELLOW, Color.MAGENTA, Color.ORANGE, Color.CYAN]
	new_bug.get_node("Sprite2D").modulate = color_list.pick_random()
	
	add_child(new_bug)

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	pause_menu.show()
