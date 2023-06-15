extends ProgressBar

@onready var timer = $regenerationTimer
var moved = false

var tmpEnergy
var shrinking = false

var tween: Tween
var moveTween: Tween

func _ready():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	moveTween = get_tree().create_tween()
	moveTween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	tmpEnergy = GLOBALS.endurance2
	set_process(true)

func _process(delta):
	if GLOBALS.endurance2 != tmpEnergy:
		if GLOBALS.endurance2 < tmpEnergy:
			shrinking = true
		else: shrinking = false
		#value = tmpEnergy
		tween.tween_property(self, "value", GLOBALS.endurance2, 0.2)
	if GLOBALS.endurance2 < 100 && timer.is_stopped() && not shrinking:
		GLOBALS.endurance2 = GLOBALS.endurance2 + 1
		timer.start()
	if GLOBALS.players >= 2 && not moved:
		visible = true
		move()
		moved = true

func move():
	moveTween.tween_property(self, "position", Vector2(990, get("position").y), 0.5)
