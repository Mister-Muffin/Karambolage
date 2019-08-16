extends Node2D

func _ready():
	position = Vector2(rand_range(100, 1820), rand_range(100, 980))


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		INVENTORY.add_item("health")
		queue_free()
