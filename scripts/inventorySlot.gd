class_name Slot
extends Control

var slotNumber: int = 0

const health := 20

var itemCount: int = 0

var type: Item.TYPES

signal addEnergy

func _ready():
	$number.text = str(itemCount) # TODO: set to 0 in editor


func _process(delta):
	if Input.is_action_just_pressed(str(slotNumber)) and type != null:
		if itemCount >= 1:
			_remove_item()
			if type == Item.TYPES.HEALTH:
				_updateHealth()
			if type == Item.TYPES.ENERGY:
				_updateEnergy()

func _updateHealth():
	GLOBALS.signal_change_health(health, 1)
	GLOBALS.signal_change_health(health, 2)

func _updateEnergy():
	GLOBALS.signal_change_energy(30, 1)
	GLOBALS.signal_change_energy(30, 2)


func change_slot_number(number: int):
	slotNumber = number
	$slot.text = str(slotNumber)


func add_item(t: Item.TYPES, texture: Resource):
	print(t)
	type = t
	if itemCount == 0:
		$animPlayer.play("anim")

	$"container/textureRect/animPlayer".play("zoom")
	itemCount += 1
	$number.text = str(itemCount)
	$"container/item".texture = texture


func _remove_item():
	if itemCount >= 1:
		itemCount -= 1
	$number.text = str(itemCount)
	if itemCount <= 0:
		$animPlayer.play_backwards("anim")
