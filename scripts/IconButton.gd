extends Control

var entered = false

func _ready():
	set_process(true)

func _process(delta):
	if get_node("../../../../Main").visible: visible = true
	else: visible = false

#func _on_areaButton_area_shape_entered(area_id, area, area_shape, self_shape):
#	if not entered && area.name == "Mouse":
#		$animPlayer.play("anim")
#		entered = true
#
#
#func _on_areaButton_area_shape_exited(area_id, area, area_shape, self_shape):
#	if entered && area.name == "Mouse":
#		$animPlayer.play_backwards("anim")
#		entered = false
