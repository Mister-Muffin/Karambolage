extends KinematicBody2D

var direction = (GLOBALS.playerPos - global_position).normalized()

func _ready():
	direction = (GLOBALS.playerPos - global_position).normalized()

func _process(delta):
	direction = (GLOBALS.playerPos - global_position).normalized()
	move_and_collide(direction * 100 * get_physics_process_delta_time())