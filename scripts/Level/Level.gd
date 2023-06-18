extends Control

@export var playerScene: PackedScene

@export var healthBarScene: PackedScene
@export var energyBarScene: PackedScene

@onready var infoPanel = get_node("uiElements/infoPanel")
@onready var base = get_node("uiElements/gameElements/Base")
@onready var letterCountdown = get_node("uiElements/gameElements/letterCountdown")
@onready var letterCountdownTimer = get_node("uiElements/gameElements/letterCountdown/timer")
@onready var letterCountdownLabel = get_node("uiElements/gameElements/letterCountdown/letterLabel")
@onready var letterCountdownProgress = get_node("uiElements/gameElements/letterCountdown/progressBar")

var infoPanelTween: Tween

var contCancel = false

var spacePressed = false

var initPos = Vector2()
var endPosY

var spawned := false

func _ready():
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

				var playerInstance = playerScene.instantiate()
				playerInstance.first = false

				var healthBarInstance: ProgressBar = healthBarScene.instantiate()
				healthBarInstance.position = Vector2(560, 67)
				healthBarInstance.player = 2
				# needed in order, that animation player won't animate
				# both player's health bars
				var healthBarMaterial: StyleBoxFlat = healthBarInstance.get("theme_override_styles/fill")
				healthBarInstance.set("theme_override_styles/fill", healthBarMaterial.duplicate())

				var energyBarInstance: ProgressBar = energyBarScene.instantiate()
				energyBarInstance.position = Vector2(560, 28)
				energyBarInstance.player = 2
				var energyBarMaterial: StyleBoxFlat = energyBarInstance.get("theme_override_styles/fill")
				energyBarInstance.set("theme_override_styles/fill", energyBarMaterial.duplicate())

				$container.add_child(playerInstance)
				base.add_child(healthBarInstance)
				base.add_child(energyBarInstance)
				GLOBALS.signal_p2_join()


func _process(delta):
	if Input.is_action_just_pressed("ui_select") && not spacePressed:
		spacePressed = true
		if infoPanelTween: infoPanelTween.kill()
		infoPanelTween = get_tree().create_tween()
		infoPanelTween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		infoPanelTween.tween_property(infoPanel, "position", Vector2(initPos.x, endPosY), 0.5)

	if Input.is_action_just_released("ui_select") && spacePressed:
		spacePressed = false
		if infoPanelTween: infoPanelTween.kill()
		infoPanelTween = get_tree().create_tween()
		infoPanelTween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		infoPanelTween.tween_property(infoPanel, "position", Vector2(initPos.x, initPos.y), 0.5)

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
