extends Node

var countDown = false

var enemys = 0

var cave = true

var enemysInCollision1 = 0
var enemysInCollision2 = 0

var fast = false

var splashDone = false

var score = 0

var health1 = 100
var health2 = 100

var enduranceUsing = false

var powerupType

var players = 0

#settings

var closeConfirmation = true

var powerupPos = Vector2()
var popupShown = false

#inventory

var itemSlot1 = ""
var itemSlot2 = ""

signal change_energy(newValue: int, player: int)
func signal_change_energy(newValue: int, player: int):
	change_energy.emit(newValue, player)
