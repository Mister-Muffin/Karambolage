extends CharacterBody2D

@export var speed := 100

var detected := false
var move := false

var direction

var player: Player


func _ready():
	position = Vector2(randf_range(28, get_viewport_rect().size.x - 28), randf_range(28, get_viewport_rect().size.y - 28))
	get_node("ExclamationMark").visible = false

func _physics_process(delta):
	if move:
		move_and_collide(direction * speed * delta)

func _process(delta):
	if detected and player:
		direction = (player.position - global_position).normalized()
		move = true
	else:
		move = false


func _on_detectingArea_body_entered(body):
	if body is Player:
		player = body
		detected = true

func _on_detectingArea_body_exited(body):
	$ExclamationMark.visible = false
	if body is Player: detected = false


func _on_collsisionArea_body_entered(body):
	if body is Player:
		body.dealDamage()
		self.queue_free()

func _on_collsisionArea_body_exited(body):
	pass


func _on_warning_area_body_entered(body):
	if body is Player:
		$ExclamationMark.visible = true
		if not $ExclamationMark/animPlayer.is_playing(): $ExclamationMark/animPlayer.play("question")
		await get_tree().process_frame

func _on_warning_area_body_exited(body):
	if body is Player:
		$ExclamationMark/animPlayer.stop(true)
		$ExclamationMark.visible = false
