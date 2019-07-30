extends Control

var entered = false

func _ready():
	pass


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	print("E")
	if not entered && area.name == "Mouse":
		$AnimationPlayer.play("zoom")
		entered = true


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if entered && area.name == "Mouse":
		$AnimationPlayer.play_backwards("zoom")
		entered = false
