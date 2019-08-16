extends Node2D

var item = preload("res://scenes/Item.tscn")

func _on_timer_timeout():
	spawn()

func spawn():
	$container.add_child(item.instance())