extends Marker2D

@export var itemScene: PackedScene
var pos = Vector2()

var types = ["health", "energy"]

func _on_timer_timeout():
	$particles.emitting = false
	spawn()
	$particlesTimer.start()

func spawn():
	var item = itemScene.instantiate()
	item.type = types[randf_range(0, 2)]
	item.global_position = pos
	$container.add_child(item)

func _on_particlesTimer_timeout():
	randomize()
	pos = Vector2(randf_range(100, 1820), randf_range(100, 980))
	self.global_position = pos
	$particles.emitting = true
