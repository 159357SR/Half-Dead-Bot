extends Area2D

@onready var spawn_timer = $SpawnTimer
@onready var despawn_timer = $DespawnTimer
@onready var active_timer = $ActiveTimer

# Ensure you have a TextureProgressBar named exactly "InfiniteClock" inside your UILayer!
@onready var ui_clock = $"../UILayer/InfiniteClock" 

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position.y = -1000
	if ui_clock: 
		ui_clock.hide()
	
	spawn_timer.one_shot = true
	despawn_timer.one_shot = true
	active_timer.one_shot = true

	var gap = 30.0
	match Global.difficulty:
		"easy": gap = 40.0
		"normal": gap = 27.0
		"hard": gap = 25.0
		"extreme": gap = 134.0

	spawn_timer.wait_time = gap
	spawn_timer.start()

func _process(_delta):
	if not active_timer.is_stopped() and ui_clock:
		ui_clock.value = (active_timer.time_left / active_timer.wait_time) * 100

func _on_spawn_timer_timeout():
	position.x = randf_range(50, screen_size.x - 50)
	position.y = randf_range(50, screen_size.y - 50)
	despawn_timer.start(5.0)

func _on_despawn_timer_timeout():
	position.y = -1000 
	spawn_timer.start() 

func _on_area_entered(area):
	if area.name == "Player":
		position.y = -1000
		despawn_timer.stop()
		
		Global.is_infinite_active = true
		if ui_clock: 
			ui_clock.show()
		active_timer.start(10.0)

func _on_active_timer_timeout():
	Global.is_infinite_active = false
	if ui_clock: 
		ui_clock.hide()
	spawn_timer.start()
