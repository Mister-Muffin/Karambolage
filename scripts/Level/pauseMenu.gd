extends Control

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			get_tree().paused = false
			$animPlayer.play_backwards("anim")
		else:
			$animPlayer.play("anim")
			get_tree().paused = true


func _on_btnContinue_pressed():
	get_tree().paused = false
	$animPlayer.play_backwards("anim")


func _on_btnExit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Start.tscn")


func _on_btnQuit_pressed():
	get_tree().quit()
