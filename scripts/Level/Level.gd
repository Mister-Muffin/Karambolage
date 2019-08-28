extends Control

var contCancel = false

var spacePressed = false

var initPos = Vector2()
var endPosY

var spawned = false

func _ready():
	initPos.x = $infoLayer/infoPanel.get_global_rect().position.x
	initPos.y = $infoLayer/infoPanel.get_global_rect().position.y
	endPosY = initPos.y + $infoLayer/infoPanel.get_global_rect().size.y
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if GLOBALS.fast: Engine.time_scale = 1.5
	else: Engine.time_scale = 1
	
	if GLOBALS.cave:
		get_node("Light2D").visible = true
	else:
		get_node("Light2D").visible = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var pos = Vector2()
			pos = (get_global_mouse_position() - get_node("Player").position)
			get_node("Player").move_and_collide(pos)
		elif event.pressed and event.button_index == BUTTON_RIGHT:
			get_tree().quit()
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_RIGHT:
			if not spawned:
				spawned = true
				$container.add_child(preload("res://player/Player.tscn").instance())
		

func _process(delta):		
	if Input.is_action_just_pressed("ui_select") && not spacePressed:
		spacePressed = true
		
		$infoLayer/infoPanel/Tween.interpolate_property($infoLayer/infoPanel,
		"rect_position",
		Vector2(initPos.x, initPos.y),
		Vector2(initPos.x, endPosY),
		0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
		
		$infoLayer/infoPanel/Tween.start()
	if Input.is_action_just_released("ui_select") && spacePressed:
		
		spacePressed = false
		
		$infoLayer/infoPanel/Tween.interpolate_property($infoLayer/infoPanel,
		"rect_position",
		Vector2(initPos.x, endPosY),
		Vector2(initPos.x, initPos.y),
		0.5, Tween.TRANS_BACK, Tween.EASE_IN)
		$infoLayer/infoPanel/Tween.start()
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
		if not get_node("letter_countdown/timer").is_stopped() && contCancel:
			get_node("letter_countdown/progressBar").value = (get_node("letter_countdown/timer").time_left / 1 * 100)
	
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
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene("res://scenes/Start.tscn")
