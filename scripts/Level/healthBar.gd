extends ProgressBar

var currHealth = 100
var moved = false
var colorChanged = false

var tween: Tween
var moveTween: Tween

func _ready():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	moveTween = get_tree().create_tween()
	moveTween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	set_process(true)
 
func _process(delta):
	if GLOBALS.health1 != currHealth:
		tween.tween_property(self, "value", GLOBALS.health1, 0.5)
		currHealth = GLOBALS.health1
	if GLOBALS.health1 <= 20 && not colorChanged:
		$AnimationPlayer.play("changeColor")
		colorChanged = true
	if GLOBALS.health1 > 20 && colorChanged:
		$AnimationPlayer.play_backwards("changeColor")
		colorChanged = false
	if GLOBALS.players >= 2 && not moved:
		move()
		moved = true

func move():
	moveTween.tween_property(self, "position", Vector2(130, get("position").y), 0.5)
