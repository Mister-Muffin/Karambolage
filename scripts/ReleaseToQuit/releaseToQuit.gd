extends ColorRect

func _ready():
	get_node("colorRectRed/label").text = "Release key to quit"

func _process(delta):
	if Input.is_action_just_released("quit"):
		get_node("colorRectRed/label").text = "Quitting game..."
		get_tree().quit()