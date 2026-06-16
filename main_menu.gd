extends Control

@onready var difficulty_screen = $DifficultyScreen
@onready var high_score_screen = $HighScoreScreen

@onready var diff_label = $DifficultyScreen/DiffLabel

@onready var easy_label = $HighScoreScreen/EasyScore
@onready var normal_label = $HighScoreScreen/NormalScore
@onready var hard_label = $HighScoreScreen/HardScore
@onready var extreme_label = $HighScoreScreen/ExtremeScore

@onready var credit_screen: ColorRect = $CreditScreen
@onready var quit_menu_screen: ColorRect = $QuitMenuScreen


func _ready():
	difficulty_screen.hide()
	high_score_screen.hide()

func _on_play_button_pressed():
	Global.current_score = 0
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_set_difficulty_pressed():
	diff_label.text = "CURRENT: " + Global.difficulty.capitalize()
	difficulty_screen.show()

func _on_high_score_button_pressed():
	easy_label.text = "EASY: " + str(Global.high_scores["easy"])
	normal_label.text = "NORMAL: " + str(Global.high_scores["normal"])
	hard_label.text = "HARD: " + str(Global.high_scores["hard"])
	extreme_label.text = "EXTREME: " + str(Global.high_scores["extreme"])
	high_score_screen.show()


func _on_easy_pressed():
	Global.difficulty = "easy"
	difficulty_screen.hide()

func _on_normal_pressed():
	Global.difficulty = "normal"
	difficulty_screen.hide()

func _on_hard_pressed():
	Global.difficulty = "hard"
	difficulty_screen.hide()

func _on_extreme_pressed():
	Global.difficulty = "extreme"
	difficulty_screen.hide()

func _on_close_scores_button_pressed():
	high_score_screen.hide()


func _on_credits_button_pressed() -> void:
	credit_screen.show()


func _on_back_pressed() -> void:
	credit_screen.hide() 

func _on_exit_button_pressed():
	quit_menu_screen.show()


func _on_yes_button_pressed() -> void:
	get_tree().quit()


func _on_no_button_pressed() -> void:
	quit_menu_screen.hide()
