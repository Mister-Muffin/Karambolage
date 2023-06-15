extends CharacterBody2D

const speed = 2

func _ready():
	position = GLOBALS.playerPos

func _physics_process(delta):
	move_and_collide(get_global_mouse_position().normalized() * speed)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
