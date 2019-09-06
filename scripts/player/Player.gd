extends KinematicBody2D

var collision_info
var move_direction = Vector2()


const slowSpeed = 250
const sprintSpeed = 500
var speed

const hitDelay = 0.5

onready var enduranceTimer = $enduranceTimer

export var speedEnduranceUp = 0.5 #Speed regenerating endurance
export var speedEnduranceDown = 2 #Speed using endurance

var gameEnding = false

var LEFT = Input.is_action_pressed("ui_a")
var RIGHT = Input.is_action_pressed("ui_d")
var UP = Input.is_action_pressed("ui_w")
var DOWN = Input.is_action_pressed("ui_s")
var SHIFT

var moving = false

var first = true #true when first player

signal end_game

func _ready():
	if GLOBALS.players < 1:
		GLOBALS.players = GLOBALS.players + 1
		first = true
	else:
		GLOBALS.players += 1
		first = false
		position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		add_to_group("Player2")
		remove_from_group("Player1")
		
	if GLOBALS.cave:
		$torch.visible = true
	else:
		$torch.visible = false
	speed = slowSpeed


# warning-ignore:unused_argument
func _physics_process(delta):
	if GLOBALS.cave && not gameEnding:
		$Tween.interpolate_property($torch, "texture_scale", $torch.texture_scale, $torch.texture_scale + 0.15, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

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
		SHIFT = Input.is_action_pressed("ui_second_sprint")
	
	if first:
		GLOBALS.playerPos1 = global_position
	else:
		GLOBALS.playerPos2 = global_position

	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	if LEFT || RIGHT || UP || DOWN:
		collision_info = move_and_collide(move_direction.normalized() * speed * delta)
		if not moving:
			moving = true
	else:
		if moving:
			moving = false


func _process(delta):
	if first:
		if SHIFT && moving && GLOBALS.endurance1 >= 10 && enduranceTimer.is_stopped():
			while SHIFT && GLOBALS.endurance1 > 0 && moving:
				if enduranceTimer.is_stopped():
					GLOBALS.endurance1 -= speedEnduranceDown
					enduranceTimer.start()
					speed = sprintSpeed
					$particles.emitting = true
				yield(get_tree(), "idle_frame")
		elif GLOBALS.endurance1 <= 0:
			speed = slowSpeed
			$particles.emitting = false
		if not SHIFT && GLOBALS.endurance1 <= 100 && enduranceTimer.is_stopped():
			GLOBALS.endurance1 = GLOBALS.endurance1 + speedEnduranceUp
			enduranceTimer.start()
			speed = slowSpeed
			$particles.emitting = false
	else:
		if SHIFT && moving && GLOBALS.endurance2 >= 10 && enduranceTimer.is_stopped():
			while SHIFT && GLOBALS.endurance2 > 0 && moving:
				if enduranceTimer.is_stopped():
					GLOBALS.endurance2 -= speedEnduranceDown
					enduranceTimer.start()
					speed = sprintSpeed
					$particles.emitting = true
				yield(get_tree(), "idle_frame")
		elif GLOBALS.endurance2 <= 0:
			speed = slowSpeed
			$particles.emitting = false
		if not SHIFT && GLOBALS.endurance2 <= 100 && enduranceTimer.is_stopped():
			GLOBALS.endurance2 = GLOBALS.endurance2 + speedEnduranceUp
			enduranceTimer.start()
			speed = slowSpeed
			$particles.emitting = false

	if GLOBALS.enemysInCollision1 >= 1 && $timer.is_stopped() && first:
		dealDamage()
		$timer.start(hitDelay)
	if GLOBALS.enemysInCollision2 >= 1 && $timer.is_stopped() && not first:
		dealDamage()
		$timer.start(hitDelay)
	
	if GLOBALS.health1 <= 0 && not gameEnding && first: #this should only manage the first plyer
		endGame()
	if GLOBALS.health2 <= 0 && not gameEnding && first: #same
		endGame()

func _on_Tween_tween_completed(object, key):
	if $torch.texture_scale < 1 && first && GLOBALS.cave:
		get_tree().change_scene("res://scenes/Restart.tscn")

func dealDamage():
	if first:
		GLOBALS.health1 -= 10
	else:
		GLOBALS.health2 -= 10

func endGame():
	emit_signal("end_game")
	gameEnding = true
	$Tween.interpolate_property($torch, "texture_scale", $torch.texture_scale, 0.01, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()