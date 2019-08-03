extends Control

func _ready():
	$info/animPlayer.play("blend")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			get_tree().change_scene("res://scenes/Start.tscn")
			#