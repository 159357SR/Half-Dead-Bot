extends Control

func _ready():
	$Over.text = Global.death_message
	$EndScore.text = "Score: " + str(Global.final_score)
	
	
	if Global.death_message == "SYSTEM INFECTION: CAUGHT BY VIRUS":
		$VirusMusic.play()
	elif Global.death_message == "OUT OF CHARGE":
		$BatteryMusic.play()

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
