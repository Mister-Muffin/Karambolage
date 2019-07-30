extends Control

var entered = false

export var title = "Play"

func _ready():
	$title.text = title

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if not entered && area.name == "Mouse":
		$animPlayer.play("anim")
		entered = true


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if entered && area.name == "Mouse":
		$animPlayer.play_backwards("anim")
		entered = false


func _on_button_pressed():
	pass