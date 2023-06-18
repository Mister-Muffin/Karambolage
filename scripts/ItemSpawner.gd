extends Marker2D

@export var itemScene: PackedScene

@export_category("Item Textures")
@export var texture_health: Resource
@export var texture_energy: Resource

var pos := Vector2()

func _on_timer_timeout():
	$particles.emitting = false
	spawn()
	$particlesTimer.start()

func spawn():
	var item: Item = itemScene.instantiate()

	item.type = Item.TYPES.HEALTH
	item.global_position = pos
	item.set_texture(texture_health)

	$container.add_child(item)

func _on_particlesTimer_timeout():
	pos = Vector2(randf_range(100, 1820), randf_range(100, 980))
	self.global_position = pos
	$particles.emitting = true
