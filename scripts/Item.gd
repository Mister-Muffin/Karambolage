extends Node2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("AnyPlayer"):
		INVENTORY.add_item("health")
		queue_free()

func _ready():
	position = GLOBALS.powerupPos