extends KinematicBody2D

var detected = false

func _ready():
	position = Vector2(rand_range(64, 1920 -64), rand_range(64, 1016))
	$ExclamationMark.visible = false


func _on_detectingArea_body_entered(body):
	if body.is_in_group("Player"): detected = true
	while body.is_in_group("Player") && detected:
		if not get_tree().paused:
			$ExclamationMark.visible = true
			$ExclamationMark/animPlayer.play("axclamMark")
			var direction = (GLOBALS.playerPos - global_position).normalized()
			move_and_collide(direction * 100 * get_physics_process_delta_time())
			yield(get_tree(), "idle_frame")
		else: yield(get_tree(), "idle_frame")


func _on_detectingArea_body_exited(body):
	if body.is_in_group("Player"): 
		detected = false
		$ExclamationMark.visible = false

func _on_collsisionArea_body_entered(body):
	if body.is_in_group("Player"): GLOBALS.enemysInCollision -= 1

func _on_collsisionArea_body_exited(body):
	if body.is_in_group("Player"): GLOBALS.enemysInCollision -= 1


func _on_warningArea_body_entered(body):
	if body.is_in_group("Player"):
		$ExclamationMark.visible = true
		if not $ExclamationMark/animPlayer.is_playing(): $ExclamationMark/animPlayer.play("question")
		yield(get_tree(), "idle_frame")


func _on_warningArea_body_exited(body):
	if body.is_in_group("Player"):
		$ExclamationMark/animPlayer.stop(true)
		$ExclamationMark.visible = false
