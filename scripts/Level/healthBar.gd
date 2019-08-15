extends ProgressBar

var currHealth = 100

var greenColor

func _ready():
	set_process(true)
	greenColor = get("custom_styles/fg")
	print(greenColor)
 
func _process(delta):
	if GLOBALS.health != currHealth:
		$Tween.interpolate_property(self, "value", currHealth, GLOBALS.health, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()
		currHealth = GLOBALS.health
	if GLOBALS.health <= 20 && get("custom_styles/fg/bg_color") == greenColor:
		$Tween.interpolate_property(self, "custom_styles/fg/bg_color", greenColor, Color("ff0000"), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()