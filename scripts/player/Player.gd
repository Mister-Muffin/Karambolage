extends KinematicBody2D

var collision_info
var move_direction = Vector2()


const slowSpeed = 250
const sprintSpeed = 500
var speed

onready var enduranceTimer = $enduranceTimer

export var speedEnduranceUp = 0.5 #Speed regenerating endurance
export var speedEnduranceDown = 2 #Speed using endurance

var gameEnding = false

var LEFT = Input.is_action_pressed("ui_a")
var RIGHT = Input.is_action_pressed("ui_d")
var UP = Input.is_action_pressed("ui_w")
var DOWN = Input.is_action_pressed("ui_s")
var SHIFT

var first = true #true when first player

signal end_game

func _ready():
	if GLOBALS.players < 1:
		GLOBALS.players = GLOBALS.players + 1
		first = true
	else:
		first = false
		
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
	
	GLOBALS.playerPos = global_position
	
	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	
	if LEFT || RIGHT || UP || DOWN:
		collision_info = move_and_collide(move_direction.normalized() * speed * delta)


func _process(delta):
	if SHIFT && first && GLOBALS.endurance >= 10 && enduranceTimer.is_stopped():
		while SHIFT && GLOBALS.endurance > 0:
			if enduranceTimer.is_stopped():
				GLOBALS.endurance = GLOBALS.endurance - speedEnduranceDown
				enduranceTimer.start()
				speed = sprintSpeed
				$particles.emitting = true
			yield(get_tree(), "idle_frame")
	elif GLOBALS.endurance <= 0:
		speed = slowSpeed
		$particles.emitting = false
	if not SHIFT && first && GLOBALS.endurance <= 100 && enduranceTimer.is_stopped():
		GLOBALS.endurance = GLOBALS.endurance + speedEnduranceUp
		enduranceTimer.start()
		speed = slowSpeed
		$particles.emitting = false
	if GLOBALS.enemysInCollision >= 1 && $timer.is_stopped():
		GLOBALS.health = GLOBALS.health - 10
		$timer.start(0.5)
	
	if GLOBALS.health <= 0 && not gameEnding:
		emit_signal("end_game")
		gameEnding = true
		$Tween.interpolate_property($torch, "texture_scale", $torch.texture_scale, 0.01, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

func _on_Tween_tween_completed(object, key):
	if $torch.texture_scale < 1 && first:
		get_tree().change_scene("res://scenes/Restart.tscn")
