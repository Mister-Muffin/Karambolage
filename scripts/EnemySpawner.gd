extends Node

const enemy = preload("res://enemy/Enemy.tscn")

func _ready():
	await get_tree().process_frame
	spawn()
	await get_tree().process_frame
	spawn()
	await get_tree().process_frame
	spawn()
	await get_tree().process_frame
	spawn()


func _on_timer_timeout():
	spawn()

func spawn():
	get_node("container").add_child(enemy.instantiate())
	GLOBALS.enemys += 1
