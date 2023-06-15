extends ProgressBar

@onready var timer = $regenerationTimer
var moved = false

var tmpEnergy
var shrinking = false

var tween: Tween
var moveTween: Tween

func _ready():
	tmpEnergy = GLOBALS.endurance1
	set_process(true)

func _process(delta):
	if GLOBALS.endurance1 != tmpEnergy:
		if GLOBALS.endurance1 < tmpEnergy:
			shrinking = true
		else: shrinking = false
		
		if tween:
			tween.kill()
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "value", GLOBALS.endurance1, 0.2)
	if GLOBALS.endurance1 < 100 && timer.is_stopped() && not shrinking:
		GLOBALS.endurance1 = GLOBALS.endurance1 + 1
		timer.start()
	if GLOBALS.players >= 2 && not moved:
		move()
		moved = true

func move():
	if moveTween:
		moveTween.kill()
	moveTween = get_tree().create_tween()
	moveTween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	moveTween.tween_property(self, "position", Vector2(130, get("position").y), 0.5)
