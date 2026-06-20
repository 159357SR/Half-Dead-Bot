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

var UNLOCKS_SAVE_PATH = "user://unlocks.save"
var equipped_avatar = "scrapper"

var avatars = {
	"scrapper": {
		"name": "Scrapper",
		"desc": "The oldie and goldie",
		"story": "The OG made of scraped parts. It scraps and is regularly normal. Yet, it gets the job done...",
		"unlocked": true,
		"unlock_condition": "Unlocked by default.",
		"ability": "none",
		"scene_path": "res://avatars/scrapper.tscn",
		"icon_path": "res://avatars/scrapper_icon.tres" #
	},
	
	"aero":{
		"name": "Aero",
		"desc": "The one that loves to fly",
		"story": "Always dreaming to 'fly' one day, Aero got a sleek, aerodynamic chassis to help with quick manuevers",
		"unlocked": false,
		"unlock_condition": "Survive 2 mins in hard mode",
		"ability": "20% speed_boost",
		"scene_path": "res://avatars/aero.tscn",
		"icon_path":"res://avatars/aero_icon.tres" #
	},
	
	"frost":{
		"name": "Frost",
		"desc": "Cold but with a hot head",
		"story": "Made in an experiment to handle sub-zero trmperatures, equipped with super coolant to freeze the viruses for a longer time",
		"unlocked": false,
		"unlock_condition": "Score 150 in normal mode",
		"ability": "20% more freeze time",
		"scene_path": "res://avatars/frost.tscn",
		"icon_path":"res://avatars/frost_icon.tres" #
	},
	
	"ardor":{
		"name": "Ardor",
		"desc": "Always eager to go fast and faster",
		"story": "Ardor is always eager and tempted towards speed making him go fast for a bit longer",
		"unlocked": false,
		"unlock_condition": "Survive 5 mins in hard mode",
		"ability": "30% more speed up time",
		"scene_path": "res://avatars/ardor.tscn",
		"icon_path":"res://avatars/ardor_icon.tres" #
	}
}

var is_speed_active: bool = false
var is_freeze_active: bool = false
var is_infinite_active: bool = false
var current_run_time: float = 0.0
var is_playing: bool = false

const SAVE_PATH = "user://highscores.save"

func _ready():
	load_scores()
	load_unlocks()

func _process(delta):
	if is_playing == true:
		current_run_time += delta

func check_and_save_score():
	if final_score > high_scores[difficulty]:
		high_scores[difficulty] = final_score
		save_scores()

func save_scores():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(high_scores)

func check_unlocks():
	#AERO
	if avatars["aero"]["unlocked"] == false:
		if current_run_time >= 120.0 and difficulty == "hard":
			avatars["aero"]["unlocked"] = true
			print("ACHIEVEMENT UNLOCKED: Aero!")
			save_unlocks()
	
	#FROST
	if avatars["frost"]["unlocked"] == false:
		if current_score >= 150 and difficulty == "normal":
			avatars["frost"]["unlocked"] = true
			print("ACHIEVEMENT UNLOCKED: Frost!")
			save_unlocks()
	
	#ARDOR
	if avatars["ardor"]["unlocked"] == false:
		if current_run_time >= 300 and difficulty == "hard":
			avatars["frost"]["unlocked"] = true
			print("ACHIEVEMENT UNLOCKED: Ardor!")
			save_unlocks()
	

func save_unlocks():
	var _file = FileAccess.open(UNLOCKS_SAVE_PATH, FileAccess.WRITE)
	var unlocked_bots = []
	for bot in avatars:
		if avatars[bot]["unlocked"] == true:
			unlocked_bots.append(bot)

func load_unlocks():
	if FileAccess.file_exists(UNLOCKS_SAVE_PATH):
		var file = FileAccess.open(UNLOCKS_SAVE_PATH, FileAccess.READ)
		
		if file.get_length() >0:
			var unlocked_bots = file.get_var()
			if unlocked_bots != null:
				for bot in unlocked_bots:
					if avatars.has(bot):
						avatars[bot]["unlocked"]= true

func load_scores():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			high_scores = file.get_var()
