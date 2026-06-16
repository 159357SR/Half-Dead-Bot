extends Control

var avatar_keys = []
var current_index = 0

func _ready():
	avatar_keys = Global.avatars.keys()
	
	current_index = avatar_keys.find(Global.equipped_avatar)
	
	$PrevButton.pressed.connect(_on_prev_pressed)
	$NextButton.pressed.connect(_on_next_pressed)
	$SelectButton.pressed.connect(_on_select_pressed)
	
	update_menu()

func update_menu():

	var current_bot_id = avatar_keys[current_index]
	var bot_data = Global.avatars[current_bot_id]
	
	$NameLabel.text = bot_data["name"]
	$BotImage.texture = load(bot_data["icon_path"])
	
	if bot_data["unlocked"] == true:
		$DescLabel.text = bot_data["desc"] + "\n\n" + bot_data["story"]
		$SelectButton.disabled = false
		$SelectButton.text = "SELECT"
		
		$BotImage.modulate = Color(1, 1, 1, 1) 
	else:
		$DescLabel.text = "LOCKED STATUS\n\nHow to unlock:\n" + bot_data["unlock_condition"]
		$SelectButton.disabled = true
		$SelectButton.text = "LOCKED"
		
		# Optional: Darken the locked image like a silhouette 
		$BotImage.modulate = Color(0.2, 0.2, 0.2, 1)

func _on_prev_pressed():
	current_index -= 1
	if current_index < 0:
		current_index = avatar_keys.size() - 1
	update_menu()

func _on_next_pressed():
	current_index += 1
	if current_index >= avatar_keys.size():
		current_index = 0
	update_menu()

func _on_select_pressed():
	Global.equipped_avatar = avatar_keys[current_index]
	
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
