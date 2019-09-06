extends Control

func _ready():
	$ColorRect/labelScore.text = "Score: " + String(GLOBALS.score)
	GLOBALS.enemys = 0
	GLOBALS.health1 = 100
	GLOBALS.health2 = 100
	GLOBALS.endurance1 = 100
	GLOBALS.endurance2 = 100
	GLOBALS.players = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_btnRestart_pressed():
	restart()
	
func _on_btnETMenu_pressed():
	exit()

# warning-ignore:return_value_discarded
func restart(): get_tree().change_scene("res://scenes/Level.tscn")

# warning-ignore:return_value_discarded
func exit(): get_tree().change_scene("res://scenes/Start.tscn")
