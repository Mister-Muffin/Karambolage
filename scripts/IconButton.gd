extends Control

var entered = false

export (String, "Settings", "Highscores") var mode

func _ready():
	set_process(true)

func _process(delta):
	if get_node("../../../../Main").visible: visible = true
	else: visible = false


func _on_button_pressed():
	if mode == "Settings":
		GLOBALS.cave = true
		GLOBALS.fast = false
	elif mode == "Highscores":
		GLOBALS.fast = true
		GLOBALS.cave = false
	else:
		GLOBALS.fast = false
		GLOBALS.cave = false

func _on_areaButton_area_shape_entered(area_id, area, area_shape, self_shape):
	if not entered && area.name == "Mouse":
		$animPlayer.play("anim")
		entered = true


func _on_areaButton_area_shape_exited(area_id, area, area_shape, self_shape):
	if entered && area.name == "Mouse":
		$animPlayer.play_backwards("anim")
		entered = false
