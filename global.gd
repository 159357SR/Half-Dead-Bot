extends Node

var difficulty = "normal"
var death_message = ""
var current_score = 0
var final_score = 0

var high_scores = {
	"easy": 0,
	"normal": 0,
	"hard": 0,
	"extreme": 0
}

var is_speed_active: bool = false
var is_freeze_active: bool = false
var is_infinite_active: bool = false

const SAVE_PATH = "user://highscores.save"

func _ready():
	load_scores()

func check_and_save_score():
	if final_score > high_scores[difficulty]:
		high_scores[difficulty] = final_score
		save_scores()

func save_scores():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(high_scores)

func load_scores():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			high_scores = file.get_var()
