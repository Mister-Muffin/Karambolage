extends Node

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("ui_p"):
		if get_tree().paused:
			get_tree().paused = false
		else: get_tree().paused = true
