extends Control

#You are welcome to clean this code up!

var entered = false
var block = false
var exit = false

@export var swipeTime = 0.5

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if not entered && area.name == "Mouse":
		entered = true
		swipe_in()
		$btnSettings/animPlayer.play("anim")
	block = true
	exit = false

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	block = false
	if exit == true:
		swipe_out()
		$btnSettings/animPlayer.play_backwards("anim")
		entered = false

func _on_areaControl_area_shape_entered(area_id, area, area_shape, self_shape):
	exit = false

func _on_areaControl_area_shape_exited(area_id, area, area_shape, self_shape):
	exit = true
	if entered && area.name == "Mouse" && not block:
		entered = false
		swipe_out()
		$btnSettings/animPlayer.play_backwards("anim")

func swipe_in():
	$"Tween".interpolate_property(self, "position", Vector2(1920, 0), Vector2(1920 - int(self.get_global_rect().size.x), 0), swipeTime, Tween.TRANS_BACK, Tween.EASE_OUT)
	$"Tween".start()

func swipe_out():
	$"Tween".interpolate_property(self, "position", Vector2(1920 - self.get_global_rect().size.x, 0), Vector2(1920, 0), swipeTime, Tween.TRANS_BACK, Tween.EASE_OUT)
	$"Tween".start()