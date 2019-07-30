extends Label

func _ready():
	set_process(true)

func _process(delta):
	if GLOBALS.countDown && not get_node("animPlayer").is_playing():
		if not get_node("animPlayer").is_playing(): get_node("animPlayer").play("countdown")
		self.visible = true
	if not GLOBALS.countDown:
		get_node("animPlayer").stop(true)
		self.visible = false