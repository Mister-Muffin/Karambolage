extends Control

var keyBindingAnim
var keyBindingLabel

func _ready():
	set_process(true)

func _process(delta):
	
	keyBindingAnim = $"../../keyBindingCanvas/animPlayer"
	keyBindingLabel = $"../../keyBindingCanvas/infoLabel"
	
	if GLOBALS.labelVisible == null:
		GLOBALS.labelVisible = keyBindingLabel.visible
	
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			get_tree().paused = false
			$animPlayer.play_backwards("anim")
			
			if not GLOBALS.labelVisible:
				keyBindingAnim.play("blend")
				setLabelVisible(false)
				
			keyBindingLabel.text = "Esc: Pause"
			keyBindingAnim.play("slide")
			GLOBALS.labelVisible = null
			
		else:
			keyBindingAnim.play("slide")
			$animPlayer.play("anim")
			keyBindingLabel.text = "Esc: Continue"
			if not GLOBALS.labelVisible:
				setLabelVisible(true)
				keyBindingAnim.play("fadeIn")
				
			
			get_tree().paused = true
	else:
		if not get_tree().paused:
			GLOBALS.labelVisible = null
			


func _on_btnContinue_pressed():
	get_tree().paused = false
	$animPlayer.play_backwards("anim")


func _on_btnExit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Start.tscn")


func _on_btnQuit_pressed():
	get_tree().quit()

func setLabelVisible(vis):
	if vis:
		var col = keyBindingLabel.get("custom_colors/font_color")
		keyBindingLabel.set("custom_colors/font_color", Color("ffffff"))
		keyBindingLabel.visible = true
	else:
		keyBindingLabel.visible = false