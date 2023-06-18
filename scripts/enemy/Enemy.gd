extends CharacterBody2D

@export var speed := 100
@export var destroyParticles: PackedScene

@onready var label: Label = get_node("enemyLabel")

var detected := false
var move := false

var direction

var player: Player


func _ready():
	position = Vector2(randf_range(28, get_viewport_rect().size.x - 28), randf_range(28, get_viewport_rect().size.y - 28))


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
		await get_tree().process_frame
		player = body
		detected = true
		_show_exclemation_mark()

func _on_detectingArea_body_exited(body):
	if body is Player:
		detected = false
		_show_question_mark()


func _on_collsisionArea_body_entered(body):
	if body is Player:
		body.dealDamage()
		var particlesInstance: GPUParticles2D = destroyParticles.instantiate()
		particlesInstance.emitting = true
		particlesInstance.position = self.position
		get_tree().get_root().add_child(particlesInstance)
		self.queue_free()

func _on_collsisionArea_body_exited(body):
	pass


func _on_warning_area_body_entered(body):
	if body is Player:
		_show_question_mark()

func _on_warning_area_body_exited(body):
	if body is Player:
		_hide_current_mark()

func _show_question_mark():
	label.text = '?'
	label.set("theme_override_colors/font_color", Color(255, 203, 0))
	label.visible = true

func _show_exclemation_mark():
	label.text = '!'
	label.set("theme_override_colors/font_color", Color(255, 0, 0))
	label.visible = true

func _hide_current_mark():
	label.visible = false
