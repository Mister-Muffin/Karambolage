extends Control

@onready var infoPanel = get_node("uiElements/infoPanel")
@onready var letterCountdown = get_node("uiElements/gameElements/letterCountdown")
@onready var letterCountdownTimer = get_node("uiElements/gameElements/letterCountdown/timer")
@onready var letterCountdownLabel = get_node("uiElements/gameElements/letterCountdown/letterLabel")
@onready var letterCountdownProgress = get_node("uiElements/gameElements/letterCountdown/progressBar")

var infoPanelTween: Tween

var contCancel = false

var spacePressed = false

var initPos = Vector2()
var endPosY

var spawned = false

func _ready():
	infoPanelTween = get_tree().create_tween()
	infoPanelTween.set_trans(Tween.TRANS_BACK)
	
	initPos.x = infoPanel.get_global_rect().position.x
	initPos.y = infoPanel.get_global_rect().position.y
	endPosY = initPos.y + infoPanel.get_global_rect().size.y
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if GLOBALS.fast: Engine.time_scale = 1.5
	else: Engine.time_scale = 1
	
	if GLOBALS.cave:
		get_node("PointLight2D").visible = true
	else:
		get_node("PointLight2D").visible = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var pos = Vector2()
			pos = (get_global_mouse_position() - get_node("Player").position)
			get_node("Player").move_and_collide(pos)
		elif event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			get_tree().quit()
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_RIGHT or event.keycode == KEY_LEFT or event.keycode == KEY_UP or event.keycode == KEY_DOWN:
			if not spawned:
				spawned = true
				$container.add_child(preload("res://player/Player.tscn").instantiate())
		

func _process(delta):
	if Input.is_action_just_pressed("ui_select") && not spacePressed:
		spacePressed = true
		
		infoPanelTween.set_ease(Tween.EASE_OUT)
		infoPanelTween.tween_property(infoPanel, "position", Vector2(initPos.x, endPosY), 0.5)
		
	if Input.is_action_just_released("ui_select") && spacePressed:
		spacePressed = false
		
		infoPanelTween.set_ease(Tween.EASE_IN)
		infoPanelTween.interpolate_property(infoPanel, "position", Vector2(initPos.x, initPos.y), 0.5)
		
	if Input.is_action_pressed("ui_r") || Input.is_action_pressed("quit") || Input.is_action_pressed("ui_m"):
		contCancel = true
		if letterCountdownTimer.is_stopped(): letterCountdownTimer.start()
		if Input.is_action_pressed("quit"):
			letterCountdownLabel.text = "Q"
		if Input.is_action_pressed("ui_r"):
			letterCountdownLabel.text = "R"
		letterCountdown.visible = true
		if not letterCountdownTimer.is_stopped() && contCancel:
			letterCountdownProgress.value = (letterCountdownTimer.time_left / 1 * 100)
	
	if Input.is_action_just_released("ui_r") || Input.is_action_just_released("quit") || Input.is_action_just_released("ui_m"):
		contCancel = false
		letterCountdownTimer.stop()
		letterCountdown.visible = false

func _on_timer_timeout():
	if Input.is_action_pressed("ui_r"):
		get_tree().change_scene_to_file("res://scenes/Restart.tscn")
	if Input.is_action_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/ReleaseToQuit.tscn")
