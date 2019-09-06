extends Control

export (int) var slotNumber

const health = 20

var currHealthPacks = 1

var hasItem = true

func _ready():
	#$number.text = String(slotNumber)
	$number.text = String(currHealthPacks)
	set_process(true)


func _on_btn_button_down():
	updateHealth()

func _process(delta):
	if INVENTORY.newHealthPack:
		hasItem = true
		if currHealthPacks <= 0:
			$animPlayer.play("anim")
		currHealthPacks = currHealthPacks + 1
		$"container/textureRect/animPlayer".play("zoom")
		$number.text = String(currHealthPacks)
		INVENTORY.newHealthPack = false
		
	if Input.is_action_just_pressed(String(slotNumber)):
		updateHealth()

func updateHealth():
	if hasItem && not $container/item.texture == null:
		currHealthPacks = currHealthPacks - 1
		if currHealthPacks <= 0:
			hasItem = false
			$animPlayer.play_backwards("anim")
			GLOBALS.health1 += health
			GLOBALS.health2 += health
		if currHealthPacks > 0:
			hasItem = true
			GLOBALS.health1 += health
			GLOBALS.health2 += health
		if GLOBALS.health1 > 100: GLOBALS.health1 = 100
		if GLOBALS.health2 > 100: GLOBALS.health2 = 100
	$number.text = String(currHealthPacks)
