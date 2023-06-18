extends Label

var game_finished = false

func _ready():
	set_process(true)

func _process(delta):
	if not game_finished:
		if GLOBALS.countDown && not get_node("animPlayer").is_playing():
			if not get_node("animPlayer").is_playing(): get_node("animPlayer").play("countdown")
			self.visible = true
		if not GLOBALS.countDown:
			get_node("animPlayer").stop(true)
			self.visible = false

func _on_Player_end_game():
	game_finished = true
