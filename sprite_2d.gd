extends Area2D

var speed = 170 # How fast the player moves (pixels/sec)
var screen_size
var screen_center

func _ready():
	screen_center = get_viewport_rect().size / 2
	Input.action_release("down")
	Input.action_release("left")
	Input.action_release("right")
	Input.action_release("up")
	position = screen_center

func _process(delta):
	# Start with your normal base speed
	var current_speed = speed
	
	# If the power-up is grabbed, boost the speed based on difficulty!
	if Global.is_speed_active:
		match Global.difficulty:
			"easy":
				current_speed = speed * 1.5
			"normal":
				current_speed = speed * 1.5
			"hard":
				current_speed = speed * 1.5
			"extreme":
				current_speed = speed * 1.5
				
	# Apply the movement using our new current_speed
	var velocity = Input.get_vector("left", "right", "up", "down")
	position += velocity * current_speed * delta
	
	# Screen wrapping logic (X and Y axis kept intact!)
	screen_size = get_viewport_rect().size
	
	if position.x > screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = screen_size.x
		
	if position.y > screen_size.y:
		position.y = 0
	elif position.y < 0:
		position.y = screen_size.y
