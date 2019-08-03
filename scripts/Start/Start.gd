extends Control

export var autostart = true

#func _on_Button_button_down():
#	GLOBALS.cave = false
#	get_tree().change_scene("res://scenes/Level.tscn")

func _unhandled_key_input(event):
	if event.pressed && event.scancode == 32: 
		GLOBALS.cave = false
		get_tree().change_scene("res://scenes/Level.tscn")

#func _on_btnCave_button_down():
#	GLOBALS.cave = true
#	get_tree().change_scene("res://scenes/Level.tscn")

func _on_btnQuit_pressed():
	get_tree().quit()
