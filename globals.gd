extends Node

var countDown = false

var enemys = 0

var cave = true
var fast = false

var splashDone := false
var show_game_over := false

var score = 0

#settings

var closeConfirmation = true

var powerupPos = Vector2()
var popupShown = false

# signals

signal change_energy(newValue: int, player: int)
func signal_change_energy(newValue: int, player: int):
	change_energy.emit(newValue, player)

signal change_health(newValue: int, player: int)
func signal_change_health(newValue: int, player: int):
	change_health.emit(newValue, player)

signal p2_join
func signal_p2_join():
	p2_join.emit()

signal end_game
func signal_end_game():
	end_game.emit()

signal add_item(item, texture: Resource)
func signal_add_item(item, texture: Resource):
	add_item.emit(item, texture)
