extends Position2D

var enemy = preload("res://enemy/Enemy.tscn")

func _ready():
	yield(get_tree(), "idle_frame")
	if GLOBALS.fast: $timer.wait_time = 0.25
	spawn()
	yield(get_tree(), "idle_frame")
	spawn()
	yield(get_tree(), "idle_frame")
	spawn()
	yield(get_tree(), "idle_frame")
	spawn()


func _on_timer_timeout():
	spawn()

func spawn():
	#var canvasLayer = $container.get_parent().get_parent()
	var lol = 1
	$container.add_child(enemy.instance())
	GLOBALS.enemys = GLOBALS.enemys + 1
	var lol2 = 2