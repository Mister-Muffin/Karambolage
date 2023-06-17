extends Marker2D

var type

var texture_health = load("res://textures/health.png")
var texture_energy = load("res://textures/energy.png")

func _ready():
	if type == "health":
		$Sprite2D.texture = texture_health
	elif type == "energy":
		$Sprite2D.texture = texture_energy

func _on_Area2D_body_entered(body):
	if body is Player and type != null:
		GLOBALS.powerupType = type
		get_tree().call_group("Slot", "item_collected")
		queue_free()
