extends Control

export var autostart = true

func _on_Button_button_down():
	GLOBALS.cave = false
	get_tree().change_scene("res://scenes/Level.tscn")

var pressed = false

func _ready():
	set_process(true)
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
	if event.pressed and event.scancode == 81:
		if $btnQuit/Timer.is_stopped(): $btnQuit/Timer.start()
		$btnQuit/TextureProgress.visible = true
		pressed = true
	if not event.pressed and event.scancode == 81:
		$btnQuit/Timer.stop()
		$btnQuit/TextureProgress.visible = false
		pressed = false

func _process(delta):
	while pressed:
		$btnQuit/TextureProgress.value = (1 - $btnQuit/Timer.time_left / 0.5) * 100
		yield(get_tree(), "idle_frame")

func _on_btnCave_button_down():
	GLOBALS.cave = true
	get_tree().change_scene("res://scenes/Level.tscn")

func _on_btnQuit_pressed():
	get_tree().quit()

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/ReleaseToQuit.tscn")
