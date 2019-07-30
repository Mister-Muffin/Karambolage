extends Node

var animPlayer
var swiped = false

func _ready():
	animPlayer = get_node("../../Camera2D/animPlayer")

func _on_btnSwipe_pressed():
	if swiped:
		animPlayer.play_backwards("swipe")
		swiped = false
	else:
		animPlayer.play("swipe")
		swiped = true
