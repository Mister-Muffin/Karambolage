extends Control

var DOWN = Input.is_action_pressed("ui_s")

var contCancel = false

func _ready():
	if GLOBALS.cave:
		$Light2D.visible = true
		$Player/Light2D.visible = true
	else:
		$Player/Light2D.visible = false
		$Light2D.visible = false

	$ColorRect/animPlayer.play("colorLoop")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var pos = Vector2()
			pos = (get_global_mouse_position() - $Player.position)
			$Player.move_and_collide(pos)
		elif event.pressed and event.button_index == BUTTON_RIGHT:
			get_tree().quit()

func _process(delta):
	var letterCountdown = $LetterCountdownLayer/letter_countdown
	var letterLabel = $LetterCountdownLayer/letter_countdown/letterLabel
	var letterTimer = $LetterCountdownLayer/letter_countdown/timer
	var letterProgressBar = $LetterCountdownLayer/letter_countdown/progressBar
	
	if Input.is_action_just_pressed("ui_select"): $infoLayer/infoPanel/AnimationPlayer.play("inout")
	if Input.is_action_just_released("ui_select"): $infoLayer/infoPanel/AnimationPlayer.play_backwards("inout")
	if Input.is_action_pressed("ui_r") || Input.is_action_pressed("quit") || Input.is_action_pressed("ui_m"):
		contCancel = true
		if letterTimer.is_stopped(): letterTimer.start()
		if Input.is_action_pressed("quit"):
			letterLabel.text = "Q"
		if Input.is_action_pressed("ui_r"):
			letterLabel.text = "R"
		if Input.is_action_pressed("ui_m"):
			letterLabel.text = "M"
		letterCountdown.visible = true
		while not letterTimer.is_stopped() && contCancel:
			letterProgressBar.value = (letterTimer.time_left / 1 * 100)
			yield(get_tree(), "idle_frame")
	
	if Input.is_action_just_released("ui_r") || Input.is_action_just_released("quit") || Input.is_action_just_released("ui_m"):
		contCancel = false
		$LetterCountdownLayer/letter_countdown/timer.stop()
		$LetterCountdownLayer/letter_countdown.visible = false

func _on_timer_timeout():
	if Input.is_action_pressed("ui_r"):
		get_tree().change_scene("res://scenes/Restart.tscn")
	if Input.is_action_pressed("quit"):
		get_tree().change_scene("res://scenes/ReleaseToQuit.tscn")
	if Input.is_action_pressed("ui_m"):
		$closeAnim/animPlayer.play("close")
