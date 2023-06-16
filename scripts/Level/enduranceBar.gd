extends ProgressBar

@onready var timer = $regenerationTimer

var moved := false

var energy := 100

var tween: Tween
var moveTween: Tween

func _ready():
	GLOBALS.change_energy.connect(_energy_changed)

# func _process(delta):
	# if GLOBALS.players >= 2 && not moved:
	#	move()
	#	moved = true



func move():
	if moveTween: moveTween.kill()
	moveTween = get_tree().create_tween()
	moveTween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	moveTween.tween_property(self, "position", Vector2(130, get("position").y), 0.5)

func _energy_changed(val, player):
	energy += val
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "value", energy, 0.2)
