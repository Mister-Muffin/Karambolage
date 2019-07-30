extends Control

var DOWN = Input.is_action_pressed("ui_s")

var contCancel = false

func _ready():
	if GLOBALS.cave:
		get_node("Light2D").visible = true
		get_node("Player/Light2D").visible = true
	else:
		get_node("Player/Light2D").visible = false
		get_node("Light2D").visible = false

	$ColorRect/animPlayer.play("colorLoop")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var pos = Vector2()
			pos = (get_global_mouse_position() - get_node("Player").position)
			get_node("Player").move_and_collide(pos)
		elif event.pressed and event.button_index == BUTTON_RIGHT:
			get_tree().quit()

func _process(delta):
	if Input.is_action_just_pressed("ui_select"): $infoLayer/infoPanel/AnimationPlayer.play("inout")
	if Input.is_action_just_released("ui_select"): $infoLayer/infoPanel/AnimationPlayer.play_backwards("inout")
	if Input.is_action_pressed("ui_r") || Input.is_action_pressed("quit") || Input.is_action_pressed("ui_m"):
		contCancel = true
		if get_node("letter_countdown/timer").is_stopped(): get_node("letter_countdown/timer").start()
		if Input.is_action_pressed("quit"):
			get_node("letter_countdown/letterLabel").text = "Q"
		if Input.is_action_pressed("ui_r"):
			get_node("letter_countdown/letterLabel").text = "R"
		if Input.is_action_pressed("ui_m"):
			get_node("letter_countdown/letterLabel").text = "M"
		get_node("letter_countdown").visible = true
		while not get_node("letter_countdown/timer").is_stopped() && contCancel:
			get_node("letter_countdown/progressBar").value = (get_node("letter_countdown/timer").time_left / 1 * 100)
			yield(get_tree(), "idle_frame")
	
	if Input.is_action_just_released("ui_r") || Input.is_action_just_released("quit") || Input.is_action_just_released("ui_m"):
		contCancel = false
		get_node("letter_countdown/timer").stop()
		get_node("letter_countdown").visible = false

func _on_timer_timeout():
	if Input.is_action_pressed("ui_r"):
		get_tree().change_scene("res://scenes/Restart.tscn")
	if Input.is_action_pressed("quit"):
		get_tree().change_scene("res://scenes/ReleaseToQuit.tscn")
	if Input.is_action_pressed("ui_m"):
		get_node("closeAnim/animPlayer").play("close")
