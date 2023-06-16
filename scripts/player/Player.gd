extends CharacterBody2D

var collision_info
var move_direction = Vector2()

const slowSpeed = 250
const sprintSpeed = 500
var speed
var health := 100
var energy := 100

const hitDelay = 0.5

@onready var playerNumber = get_node("playerNumber")
@onready var enduranceTimer = $enduranceTimer
# used to wait after sprint before regenerating energy
@onready var cooldownTimer = $cooldownTimer

var tween: Tween

const speedEnduranceUp := 1 #Speed regenerating energy
const speedEnduranceDown := 2 #Speed using energy

var gameEnding = false

var LEFT := Input.is_action_pressed("ui_a")
var RIGHT := Input.is_action_pressed("ui_d")
var UP := Input.is_action_pressed("ui_w")
var DOWN := Input.is_action_pressed("ui_s")
var SHIFT: bool

var moving := false

var first := true # true when first player

signal end_game

func _ready():
	GLOBALS.change_health.connect(_on_change_health)
	GLOBALS.change_energy.connect(_on_change_energy)

	if GLOBALS.players < 1:
		GLOBALS.players = GLOBALS.players + 1
		first = true
	else:
		GLOBALS.players += 1
		first = false
		position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		add_to_group("Player2")
		remove_from_group("Player1")
		playerNumber.text = "P2"
		playerNumber.visible = true

	if GLOBALS.cave:
		$torch.visible = true
	else:
		$torch.visible = false
	speed = slowSpeed


func _physics_process(delta):
	if GLOBALS.cave && not gameEnding:
		if tween: tween.kill()
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($torch, "texture_scale", $torch.texture_scale + 0.15, 0.5)

	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)
	if LEFT || RIGHT || UP || DOWN:
		collision_info = move_and_collide(move_direction.normalized() * speed * delta)


func _process(delta):
	_update_movement_keys()

	if GLOBALS.players >= 2 && not playerNumber.visible && first:
		playerNumber.text = "P1"
		playerNumber.visible = true
	if SHIFT && moving && energy >= 10 && enduranceTimer.is_stopped():
		while SHIFT && energy > 0 && moving:
			cooldownTimer.start()
			if enduranceTimer.is_stopped():
				_change_energy(-speedEnduranceDown)
				enduranceTimer.start()
				speed = sprintSpeed
				$particles.emitting = true
			await get_tree().process_frame
		speed = slowSpeed
		$particles.emitting = false

	if not SHIFT && energy <= 100 && enduranceTimer.is_stopped() && cooldownTimer.is_stopped():
		_change_energy(speedEnduranceUp)
		enduranceTimer.start()
		speed = slowSpeed
		$particles.emitting = false

	if GLOBALS.enemysInCollision1 >= 1 && $timer.is_stopped() && first:
		dealDamage()
		$timer.start(hitDelay)
	if GLOBALS.enemysInCollision2 >= 1 && $timer.is_stopped() && not first:
		dealDamage()
		$timer.start(hitDelay)

	if health <= 0 && not gameEnding:
		endGame()

func _update_movement_keys():
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
	moving = LEFT || RIGHT || UP || DOWN

func _on_Tween_tween_completed(object, key):
	if $torch.texture_scale < 1 && first && GLOBALS.cave:
		get_tree().change_scene_to_file("res://scenes/Start.tscn")

func dealDamage():
	_change_health(-10)

func endGame():
	gameEnding = true
	if first:
		emit_signal("end_game")
	if GLOBALS.cave:
		if tween: tween.kill()
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($torch, "texture_scale", 0.01, 1)

func addEnergy():
	energy += 30
	if energy > 100:
		energy = 100
	if energy > 100:
		energy = 100
	if first:
		GLOBALS.signal_change_energy(30, 1)
	else:
		GLOBALS.signal_change_energy(30, 2)

func _change_energy(val):
	energy += val
	if first:
		GLOBALS.signal_change_energy(val, 1)
	else:
		GLOBALS.signal_change_energy(val, 2)

func _change_health(val):
	if first:
		GLOBALS.signal_change_health(val, 1)
	else:
		GLOBALS.signal_change_health(val, 2)

func _on_change_health(val, player):
	if player == 1 and not first: return
	if player == 2 and first: return

	health += val

func _on_change_energy(val, player):
	if player == 1 and not first: return
	if player == 2 and first: return

	energy += val
