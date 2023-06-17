extends Node2D

#Currently not in use! Use Item.gd instead.

func _on_Area2D_body_entered(body):
	if body is Player:
		queue_free()

func _ready():
	position = GLOBALS.powerupPos
