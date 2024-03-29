class_name Item
extends Marker2D

enum TYPES {HEALTH, ENERGY}

var type: TYPES
var _texture: Resource

func _on_Area2D_body_entered(body):
	if body is Player:
		GLOBALS.signal_add_item(type, _texture)
		queue_free()

func set_texture(t: Resource):
	_texture = t
	$Sprite2D.texture = _texture
