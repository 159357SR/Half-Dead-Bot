extends Control

@onready var confirm_screen = $ConfirmScreen
var pending_action = ""


func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_restart_pressed() -> void:
	pending_action = "restart"
	confirm_screen.show()
	
func _on_main_menu_pressed() -> void:
	pending_action = "menu"
	confirm_screen.show()


func _on_yes_button_pressed() -> void:
	get_tree().paused = false
	
	if pending_action == "restart":
		get_tree().reload_current_scene()
	elif pending_action == "menu":
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_no_button_pressed() -> void:
	confirm_screen.hide()
