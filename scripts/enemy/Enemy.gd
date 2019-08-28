extends KinematicBody2D

var detected1 = false
var detected2 = false

var direction
var move = false
export (int) var speed = 100

func _ready():
	position = Vector2(rand_range(64, get_viewport_rect().size.x - 64), rand_range(64, get_viewport_rect().size.y - 64))
	get_node("ExclamationMark").visible = false

func _physics_process(delta):
	if move:
		move_and_collide(direction * speed * delta)

func _process(delta):
	if detected1 || detected2 && not get_tree().paused:
		if not $ExclamationMark.visible:
			get_node("ExclamationMark").visible = true
		get_node("ExclamationMark/animPlayer").play("axclamMark")
		if detected1:
			direction = (GLOBALS.playerPos1 - global_position).normalized()
		if detected2:
			direction = (GLOBALS.playerPos2 - global_position).normalized()
		move = true
		#yield(get_tree(), "idle_frame")
	else:
		move = false
		#yield(get_tree(), "idle_frame")


func _on_detectingArea_body_entered(body):
	if body.is_in_group("AnyPlayer"): detected1 = true
	if body.is_in_group("Player1"): detected1 = true
	if body.is_in_group("Player2"): detected2 = true


func _on_detectingArea_body_exited(body):
	get_node("ExclamationMark").visible = false
	if body.is_in_group("AnyPlayer"): detected1 = false
	if body.is_in_group("Player1"): detected1 = true
	if body.is_in_group("Player2"): detected2 = true

func _on_collsisionArea_body_entered(body):
	if not body.is_in_group("AnyPlayer"): return
	GLOBALS.enemysInCollision = GLOBALS.enemysInCollision + 1


func _on_collsisionArea_body_exited(body):
	if body.is_in_group("AnyPlayer"): GLOBALS.enemysInCollision = GLOBALS.enemysInCollision - 1


func _on_warningArea_body_entered(body):
	if body.is_in_group("AnyPlayer"):
		$ExclamationMark.visible = true
		if not $ExclamationMark/animPlayer.is_playing(): $ExclamationMark/animPlayer.play("question")
		yield(get_tree(), "idle_frame")


func _on_warningArea_body_exited(body):
	if body.is_in_group("AnyPlayer"):
		$ExclamationMark/animPlayer.stop(true)
		$ExclamationMark.visible = false
