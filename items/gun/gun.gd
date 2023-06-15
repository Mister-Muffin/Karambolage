extends Node2D

var picked = false

var bullet = preload("res://items/Bullet.tscn")
var velocity

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && not picked:
		picked = true
		$texture.visible = false

func _ready():
	position = GLOBALS.powerupPos
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("mouse_left") && picked:
		$container.add_child(bullet.instantiate())
		print("shoot!")
