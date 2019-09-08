extends Control

var quit = false
onready var keyBindingAnim = $"../../keyBindingCanvas/animPlayer"
onready var keyBindingLabel = $"../../keyBindingCanvas/infoLabel"
onready var keyBindingTween = $"../../keyBindingCanvas/Tween"
onready var keyBindingTimer = $"../../keyBindingCanvas/Timer"

var initPos = Vector2()
var endPos = Vector2()

func _ready():
	set_process(true)
	initPos.x = get_global_rect().position.x
	initPos.y = get_global_rect().position.y
	endPos.x = initPos.x + get_global_rect().size.x
	endPos.y = initPos.y

func _process(delta):	
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			if GLOBALS.popupShown:
				$"../../popupLayer".closePopup()
			else:
				get_tree().paused = false
				$animPlayer.play_backwards("anim")
				
				
				
				keyBindingLabel.text = "Esc: Pause"
				keyBindingTween.interpolate_property(keyBindingLabel,
				"rect_position",
				Vector2(1590,10),
				Vector2(1671,10),
				1,
				Tween.TRANS_BACK,
				Tween.EASE_OUT)
				
				$Tween.interpolate_property(self, "rect_position", endPos, initPos, 0.5, Tween.TRANS_BACK, Tween.EASE_IN)
				$Tween.start()
				keyBindingTween.start()
				keyBindingTimer.start(5)
		else:
			keyBindingTween.interpolate_property(keyBindingLabel,
			"rect_position",
			Vector2(1671,10),
			Vector2(1590,10),
			1,
			Tween.TRANS_BACK,
			Tween.EASE_OUT)
			
			$Tween.interpolate_property(self, "rect_position", initPos, endPos, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
			$Tween.start()
			keyBindingTween.start()
			$animPlayer.play("anim")
			keyBindingLabel.text = "Esc: Continue"
			if not keyBindingLabel.visible:
				keyBindingAnim.play_backwards("blend")
				
			get_tree().paused = true


func _on_btnContinue_pressed():
	get_tree().paused = false
	$animPlayer.play_backwards("anim")

func _on_btnExit_pressed():
	quit = false
	$"../../popupLayer".showPopup("Möchten sie wirklich zurück zum Hauptmenü?")

func _on_btnQuit_pressed():
	quit = true
	$"../../popupLayer".showPopup("Möchten sie das Spiel wirklich beenden?")

func _on_ConfirmationDialog_confirmed():
	if quit:
		get_tree().quit()
	else:
		get_tree().paused = false
		get_tree().change_scene("res://scenes/Start.tscn")

func _on_animPlayer_animation_finished(anim_name):
	if not get_tree().paused: $"../../popupLayer".closePopup()

func _on_confDialog_visibility_changed():
	if not GLOBALS.closeConfirmation && $"../../popupLayer/confDialog".visible:
		$"../../popupLayer".closePopup()
		if quit:
			get_tree().quit()
		else:
			get_tree().paused = false
			get_tree().change_scene("res://scenes/Start.tscn")
