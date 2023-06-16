extends Control

# You are welcome to clean this code up!

var entered := false
var block := false
var exit := false

@export var swipeTime = 0.5

var tween: Tween

func _on_areaControl_area_shape_entered(area_id, area, area_shape, self_shape):
	exit = false

func _on_areaControl_area_shape_exited(area_id, area, area_shape, self_shape):
	exit = true
	if entered && area.name == "Mouse" && not block:
		entered = false
		swipe_out()
		$btnSettings/animPlayer.play_backwards("anim")

func swipe_in():
	if tween: tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(1920 - int(self.get_global_rect().size.x), 0), swipeTime)

func swipe_out():
	if tween: tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(1920, 0), swipeTime)


func _on_btn_settings_mouse_entered() -> void:
	if not entered:
		entered = true
		swipe_in()
		$btnSettings/animPlayer.play("anim")
	block = true
	exit = false


func _on_btn_settings_mouse_exited() -> void:
	block = false
	if exit == true:
		swipe_out()
		$btnSettings/animPlayer.play_backwards("anim")
		entered = false
