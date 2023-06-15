extends Control

enum modes {NORMAL, CAVE, FAST}

@export var title = "Play"
@export var description = ""
@export var mode: modes = modes.NORMAL

@export var ScenePath = "res://scenes/Level.tscn"

func _ready():
	set_process(true)
	$title.text = title
	$mode.text = "-" + description + "-"

func _process(delta):
	if get_node("../../../Main").visible: visible = true
	else: visible = false

func _on_button_pressed():
	GLOBALS.fast = mode == modes.FAST
	GLOBALS.cave = mode == modes.CAVE
	get_tree().change_scene_to_file(ScenePath)

func _on_button_mouse_entered():
	$animPlayer.play("anim")
	# don't cover the other buttons
	z_index += 1

func _on_button_mouse_exited():
	$animPlayer.play_backwards("anim")
	z_index -= 1
