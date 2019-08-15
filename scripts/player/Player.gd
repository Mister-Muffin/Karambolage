extends KinematicBody2D

const pixelsToMove = 10
var collision_info
var speed = 4

var gameEnding = false

signal end_game

func _physics_process(null):
	
	GLOBALS.playerPos = global_position 
	
	var move_direction = Vector2()

	var LEFT = Input.is_action_pressed("ui_a")
	var RIGHT = Input.is_action_pressed("ui_d")
	var UP = Input.is_action_pressed("ui_w")
	var DOWN = Input.is_action_pressed("ui_s")
	
	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	if LEFT || RIGHT || UP || DOWN:
		collision_info = move_and_collide(move_direction.normalized() * speed)
	
	if GLOBALS.enemysInCollision >= 1 && $timer.is_stopped():
		GLOBALS.health = GLOBALS.health - 20
		$timer.start(1)
	
	if GLOBALS.health <= 0 && not gameEnding:
		emit_signal("end_game")
		gameEnding = true
#	if collision_info:
#		if collision_info.collider.name == "Enemy":
#			get_node("livesLabel").text = "Colliding"
#			if get_node("timer").is_stopped(): get_node("timer").start()
#			GLOBALS.countDown = true
#	else:
#		get_node("livesLabel").text = "Not Colliding"
#		get_node("timer").stop()
#		GLOBALS.countDown = false


func _on_timer_timeout():
	#emit_signal("end_game")
	pass

func _on_touchUp_pressed():
	GLOBALS.playerPos = global_position 
		
	var move_direction = Vector2()

	var LEFT = Input.is_action_pressed("ui_a")
	var RIGHT = Input.is_action_pressed("ui_d")
	var UP = Input.is_action_pressed("ui_w")
	var DOWN = Input.is_action_pressed("ui_s")
	
	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	if LEFT || RIGHT || UP || DOWN:
		move_and_collide(move_direction.normalized() * speed)
