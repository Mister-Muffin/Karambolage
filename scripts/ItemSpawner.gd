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

	var randomType: Item.TYPES = Item.TYPES[Item.TYPES.keys()[randi() % 2]]
	item.type = randomType
	item.global_position = pos
	match randomType:
		Item.TYPES.HEALTH:
			item.set_texture(texture_health)
		Item.TYPES.ENERGY:
			item.set_texture(texture_energy)

	$container.add_child(item)

func _on_particlesTimer_timeout():
	pos = Vector2(randf_range(100, 1820), randf_range(100, 980))
	self.global_position = pos
	$particles.emitting = true
