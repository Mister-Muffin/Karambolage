extends KinematicBody2D

const pixelsToMove = 10
var collision_info
var speed = 4

var gameEnding = false

signal end_game

# warning-ignore:unused_argument
func _physics_process(delta):
	
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
		GLOBALS.health = GLOBALS.health - 10
		$timer.start(0.5)
	
	if GLOBALS.health <= 0 && not gameEnding:
		emit_signal("end_game")
		gameEnding = true


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
		# warning-ignore:return_value_discarded
		move_and_collide(move_direction.normalized() * speed)
