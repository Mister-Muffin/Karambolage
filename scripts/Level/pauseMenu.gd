extends Control

func _ready():
	set_process(true)

func _process(delta):
	
	var keyBindingAnim = $"../../keyBindingCanvas/animPlayer"
	var keyBindingLabel = $"../../keyBindingCanvas/infoLabel"
	
	var labelVisible = keyBindingLabel.visible
	
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			get_tree().paused = false
			$animPlayer.play_backwards("anim")
			
			if not labelVisible:
				keyBindingAnim.play("blend")
				keyBindingLabel.visible = false
				
			keyBindingLabel.text = "Esc: Pause"
			
		else:
			$animPlayer.play("anim")
			keyBindingLabel.text = "Esc: Continue"
			if not labelVisible:
				keyBindingLabel.visible = true
				keyBindingAnim.play_backwards("blend")
			get_tree().paused = true
			
			


func _on_btnContinue_pressed():
	get_tree().paused = false
	$animPlayer.play_backwards("anim")


func _on_btnExit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Start.tscn")


func _on_btnQuit_pressed():
	get_tree().quit()
