extends Tween

onready var light = get_node("../../Player/Light2D")
onready var rect = get_node("../rectUp")


func _on_Player_end_game():
	var initPos = Vector2(rect.get_global_rect().position.x, rect.get_global_rect().position.y)
	var endPos = Vector2(rect.get_global_rect().position.x, 0)
	if GLOBALS.cave:
		interpolate_property(light,
		"texture_scale",
		light.texture_scale,
		0.01,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
		start()
		
	else:
		interpolate_property(rect,
		"rect_position",
		initPos,
		endPos,
		1.5,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT)
		start()


func _on_Tween_tween_completed(object, key):
	light.visible = false
	get_tree().change_scene("res://scenes/Restart.tscn")
