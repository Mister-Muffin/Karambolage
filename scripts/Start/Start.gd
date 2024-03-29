extends Control

var pressed = false

func _on_Button_button_down():
	GLOBALS.cave = false
	get_tree().change_scene_to_file("res://scenes/Level.tscn")

func _ready():
	Engine.time_scale = 1
	GLOBALS.closeConfirmation = SETTINGS.get_setting("settings", "closeConf")
	set_process(true)
	if GLOBALS.splashDone:
		if not GLOBALS.show_game_over:
			switch()
	if GLOBALS.show_game_over:
		$camera.position = Vector2(0, 1080)
		switch()
		get_node("Main/CanvasLayer/sideBoard/btnSettings").visible = false
	else:
		$camera.position = Vector2(0, 0)
	resetGlobals()


func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			$animPlayer.play("switch")
			GLOBALS.splashDone = true
	if event.pressed && event.keycode == 32:
		GLOBALS.cave = false
		get_tree().change_scene_to_file("res://scenes/Level.tscn")
	if event.pressed and event.keycode == 81:
		if $btnQuit/Timer.is_stopped(): $btnQuit/Timer.start()
		$btnQuit/TextureProgressBar.visible = true
		pressed = true
	if not event.pressed and event.keycode == 81:
		$btnQuit/Timer.stop()
		$btnQuit/TextureProgressBar.visible = false
		pressed = false

func _process(delta):
	while pressed:
		$btnQuit/TextureProgressBar.value = (1 - $btnQuit/Timer.time_left / 0.5) * 100
		await get_tree().process_frame

func _on_btnCave_button_down():
	GLOBALS.cave = true
	get_tree().change_scene_to_file("res://scenes/Level.tscn")

func _on_btnQuit_pressed():
	get_tree().quit()

func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://scenes/ReleaseToQuit.tscn")

func switch():
	%playButtons.set("modulate", Color(1, 1, 1, 1))
	$Main.visible = true
	$Splash.visible = false

func resetGlobals():
	GLOBALS.enemys = 0
