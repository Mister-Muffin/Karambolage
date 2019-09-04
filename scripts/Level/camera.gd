extends Camera2D

var tmpHealth = 100

export var magnitude = 5.0
export var lifeTime = 0.2
var timeLeft = 1.0

var isShaking = false

func _ready():
	tmpHealth = GLOBALS.health

func _physics_process(delta):
	if tmpHealth > GLOBALS.health:
		if GLOBALS.health >= 0:
			shake(delta)
		tmpHealth = GLOBALS.health
	else:
		tmpHealth = GLOBALS.health

func shake(delta):
	timeLeft = lifeTime

	if isShaking: return
	isShaking = true

	while timeLeft > 0:
		position = Vector2(rand_range(-magnitude, magnitude), rand_range(-magnitude, magnitude))

		timeLeft -= delta
		yield(get_tree(), "idle_frame")
	
	timeLeft = lifeTime
	isShaking = false
	position = Vector2(0, 0)