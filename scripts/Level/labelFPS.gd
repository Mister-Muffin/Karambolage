extends Label

func _ready():
	set_process(true)

func _process(delta):
	while Input.is_action_pressed("ui_select"):
		text = "FPS: " + str(Engine.get_frames_per_second())
		await get_tree().create_timer(0.1, false).timeout
	text = "FPS: N/A"
