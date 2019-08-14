extends Control

var quit = false
onready var popupAnim = $"../../popupLayer/animPlayer"
onready var popup = $"../../popupLayer/confDialog"
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
			get_tree().paused = false
			$animPlayer.play_backwards("anim")
			
			popupAnim.play_backwards("zoom")
			
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
	popupAnim.play_backwards("zoom")

func _on_btnExit_pressed():
	quit = false
	popup.show()
	popupAnim.play("zoom")

func _on_btnQuit_pressed():
	quit = true
	popup.show()
	popupAnim.play("zoom")

func _on_ConfirmationDialog_confirmed():
	if quit:
		get_tree().quit()
	else:
		get_tree().paused = false
		get_tree().change_scene("res://scenes/Start.tscn")

func _on_animPlayer_animation_finished(anim_name):
	if not get_tree().paused: popup.visible = false

func _on_confDialog_visibility_changed():
	if not GLOBALS.closeConfirmation && popup.visible:
		popup.visible = false
		if quit:
			get_tree().quit()
		else:
			get_tree().paused = false
			get_tree().change_scene("res://scenes/Start.tscn")
