extends Control

var initPos = Vector2()
var endPos = Vector2()

var tween: Tween

func _ready():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	initPos = get("position")
	endPos = Vector2(0, 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("AnyPlayer"):
		tween.tween_property(self, "position", endPos, 0.5)

func _on_Area2D_body_exited(body):
	if body.is_in_group("AnyPlayer"):
		tween.tween_property(self, "position", initPos, 0.5)
