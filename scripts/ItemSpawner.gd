extends Node2D

var item = preload("res://scenes/Item.tscn")

func _ready():
	GLOBALS.powerupPos = Vector2(rand_range(100, 1820), rand_range(100, 980))

func _on_timer_timeout():
	$particles.emitting = false
	spawn()
	$particlesTimer.start()

func spawn():
	$container.add_child(item.instance())

func _on_particlesTimer_timeout():
	randomize()
	GLOBALS.powerupPos = Vector2(rand_range(100, 1820), rand_range(100, 980))
	position = GLOBALS.powerupPos
	$particles.emitting = true
