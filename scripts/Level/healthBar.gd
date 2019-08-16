extends ProgressBar

var currHealth = 100


func _ready():
	set_process(true)
 
func _process(delta):
	if GLOBALS.health != currHealth:
		$Tween.interpolate_property(self, "value", currHealth, GLOBALS.health, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()
		currHealth = GLOBALS.health