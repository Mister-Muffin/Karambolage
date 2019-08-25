extends ProgressBar

const shake_amount = 100
var currHealth = 100


func _ready():
	set_process(true)
 
func _process(delta):
	if GLOBALS.health != currHealth:
		$Tween.interpolate_property(self, "value", currHealth, GLOBALS.health, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()
		currHealth = GLOBALS.health
	if GLOBALS.health <= 20 && not GLOBALS.colorChanged:
		$AnimationPlayer.play("changeColor")
		GLOBALS.colorChanged = true
	if GLOBALS.health > 20 && GLOBALS.colorChanged:
		$AnimationPlayer.play_backwards("changeColor")
		GLOBALS.colorChanged = false