extends ColorRect

func _process(delta):
	if Input.is_action_just_released("quit"):
		%label.text = "Quitting game..."
		get_tree().quit()
