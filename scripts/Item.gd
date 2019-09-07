extends Node2D

var type

var texture_health = load("res://textures/health.png")
var texture_energy = load("res://textures/energy.png")

func _ready():
	position = GLOBALS.powerupPos
	if type == "health":
		$Sprite.texture = texture_health
	elif type == "energy":
		$Sprite.texture = texture_energy

func _on_Area2D_body_entered(body):
	if body.is_in_group("AnyPlayer") && not type == null:
		GLOBALS.powerupType = type
		get_tree().call_group("Slot", "item_collected")
		queue_free()