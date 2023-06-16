extends Node

var countDown = false

var enemys = 0

var cave = true

var enemysInCollision1 = 0
var enemysInCollision2 = 0

var fast = false

var splashDone = false

var score = 0

var enduranceUsing = false

var powerupType

var players = 0

var show_game_over := false

#settings

var closeConfirmation = true

var powerupPos = Vector2()
var popupShown = false

#inventory

var itemSlot1 = ""
var itemSlot2 = ""

# signals

signal change_energy(newValue: int, player: int)
func signal_change_energy(newValue: int, player: int):
	change_energy.emit(newValue, player)

signal change_health(newValue: int, player: int)
func signal_change_health(newValue: int, player: int):
	change_health.emit(newValue, player)
