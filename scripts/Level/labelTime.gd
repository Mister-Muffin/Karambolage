extends Label

var timeSurvived = 0
onready var light = get_node("../Player/Light2D")

func _on_Timer_timeout():
	timeSurvived = timeSurvived + 1
	text = String(timeSurvived)
	GLOBALS.score = timeSurvived
	if GLOBALS.cave:
		$Tween.interpolate_property(light, "texture_scale", light.texture_scale, light.texture_scale + 0.15, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		#get_node("../Player/Light2D").texture_scale += 0.1
