extends Camera2D

@export var magnitude = 5.0
@export var lifeTime = 0.2

var timeLeft = 1.0

var isShaking := false
var shouldShake := false

func _ready():
	GLOBALS.change_health.connect(_health_changed)

func _physics_process(delta):
	if shouldShake:
		shake(delta)
		shouldShake = false

func shake(delta):
	timeLeft = lifeTime

	if isShaking: return
	isShaking = true

	while timeLeft > 0:
		position = Vector2(randf_range(-magnitude, magnitude), randf_range(-magnitude, magnitude))

		timeLeft -= delta
		await get_tree().process_frame

	timeLeft = lifeTime
	isShaking = false
	position = Vector2(0, 0)

func _health_changed(val, player):
	if val < 0:
		shouldShake = true
