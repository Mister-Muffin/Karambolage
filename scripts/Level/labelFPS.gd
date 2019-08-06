extends Label

func _ready():
	set_process(true)

func _process(delta):
	while Input.is_action_pressed("ui_select"):
		text = "FPS: " + String(Engine.get_frames_per_second())
		yield(get_tree(), "idle_frame")
	text = "FPS: N/A"