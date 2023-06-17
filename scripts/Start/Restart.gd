extends Control

@onready var camera = get_node("../camera")

var tween: Tween

const initColorScale = Vector2(0, 1080)
const endColorScale = Vector2(0, 0)

func _ready():
	$ColorRect/labelScore.text = "Score: " + str(GLOBALS.score)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$animPlayer.play("fade_in")


func _on_btnRestart_pressed():
	restart()

func _on_btnETMenu_pressed():
	if tween: tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(camera, "position", endColorScale, 0.5)
	switch()

func _on_tween_tween_all_completed():
	get_node("../Main/CanvasLayer/sideBoard/btnSettings").visible = true

# warning-ignore:return_value_discarded
func restart(): get_tree().change_scene_to_file("res://scenes/Level.tscn")

# warning-ignore:return_value_discarded
func exit(): get_tree().change_scene_to_file("res://scenes/Start.tscn")

func switch():
	get_node("../Main").visible = true
	get_node("../Splash").visible = false
