extends KinematicBody2D

const pixelsToMove = 10
var collision_info
var speed = 4

onready var enduranceTimer = $enduranceTimer

var gameEnding = false

var LEFT = Input.is_action_pressed("ui_a")
var RIGHT = Input.is_action_pressed("ui_d")
var UP = Input.is_action_pressed("ui_w")
var DOWN = Input.is_action_pressed("ui_s")
var SHIFT

var first = true

signal end_game

func _ready():
	if GLOBALS.players < 1:
		GLOBALS.players = GLOBALS.players + 1
		first = true
	else:
		first = false

# warning-ignore:unused_argument
func _physics_process(delta):
	if first:
		LEFT = Input.is_action_pressed("ui_a")
		RIGHT = Input.is_action_pressed("ui_d")
		UP = Input.is_action_pressed("ui_w")
		DOWN = Input.is_action_pressed("ui_s")
		SHIFT = Input.is_action_pressed("ui_sprint")
	else:
		LEFT = Input.is_action_pressed("ui_left")
		RIGHT = Input.is_action_pressed("ui_right")
		UP = Input.is_action_pressed("ui_up")
		DOWN = Input.is_action_pressed("ui_down")
	
	GLOBALS.playerPos = global_position
	
	var move_direction = Vector2()
	
	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	if SHIFT && first && GLOBALS.endurance >= 10 && enduranceTimer.is_stopped():
		while SHIFT && GLOBALS.endurance > 0:
			GLOBALS.endurance = GLOBALS.endurance - 1
			enduranceTimer.start(0.1)
			speed = 8
			yield(get_tree(), "idle_frame")
	if GLOBALS.endurance <= 0: speed = 4
	if not SHIFT && first && GLOBALS.endurance <= 100 && enduranceTimer.is_stopped():
		GLOBALS.endurance = GLOBALS.endurance + 1
		enduranceTimer.start(0.2)
		speed = 4
	
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
	
	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	if LEFT || RIGHT || UP || DOWN:
		# warning-ignore:return_value_discarded
		move_and_collide(move_direction.normalized() * speed)
