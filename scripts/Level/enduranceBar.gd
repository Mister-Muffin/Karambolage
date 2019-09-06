extends ProgressBar

onready var timer = $regenerationTimer
var moved = false

var tmpEndurance
var shrinking = false

func _ready():
	tmpEndurance = GLOBALS.endurance
	set_process(true)

func _process(delta):
	if GLOBALS.endurance != tmpEndurance:
		if GLOBALS.endurance < tmpEndurance:
			shrinking = true
		else: shrinking = false
		#value = tmpEndurance
		$Tween.interpolate_property(self, "value", value, GLOBALS.endurance, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()
	if GLOBALS.endurance < 100 && timer.is_stopped() && not shrinking:
		GLOBALS.endurance = GLOBALS.endurance + 1
		timer.start()
	if GLOBALS.players >= 2 && not moved:
		move()
		moved = true

func move():
	var moveTween = $moveTween
	moveTween.interpolate_property(self, "rect_position", get("rect_position"), Vector2(130, get("rect_position").y), 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	moveTween.start()