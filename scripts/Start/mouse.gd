extends Area2D

func _ready():
	set_process(true)

func _process(delta):
	position = get_global_mouse_position()
