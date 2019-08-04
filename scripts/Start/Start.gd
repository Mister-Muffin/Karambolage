extends Control

export var autostart = true

func _ready():
	$Splash/info/animPlayer.play("blend")
	if GLOBALS.splashDone:
		$Main.visible = true
		$Main/title.visible = true
		$Main/ModeContainer/CanvasLayer/btnPlay.visible = true
		$Main/ModeContainer/CanvasLayer2/btnPlayFast.visible = true
		$Main/ModeContainer/CanvasLayer3/btnCave.visible = true
		$Splash.visible = false

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			$animPlayer.play("switch")
			GLOBALS.splashDone = true
	if event.pressed && event.scancode == 32: 
		GLOBALS.cave = false
		get_tree().change_scene("res://scenes/Level.tscn")

func _on_btnQuit_pressed():
	get_tree().quit()
