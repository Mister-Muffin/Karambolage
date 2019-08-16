extends Control

export (int) var slotNumber

var hasItem = true

func _ready():
	$number.text = String(slotNumber)
	set_process(true)


func _on_btn_button_down():
	if hasItem && GLOBALS.health <= 80:
		hasItem = false
		$animPlayer.play_backwards("anim")
		GLOBALS.health = GLOBALS.health + 20
		$timer.start()
		$progressBar.visible = true

func _process(delta):
	$progressBar.value = (1 - $timer.time_left / 6) * 100
	if Input.is_action_just_pressed(String(slotNumber)):
		if hasItem && GLOBALS.health <= 80:
			hasItem = false
			$animPlayer.play_backwards("anim")
			GLOBALS.health = GLOBALS.health + 20
			$timer.start()
			$progressBar.visible = true

func _on_timer_timeout():
	hasItem = true
	$animPlayer.play("anim")
	$progressBar.visible = false


func _on_animPlayer_animation_finished(anim_name):
	#if not hasItem: $container/item.visible = false
	pass