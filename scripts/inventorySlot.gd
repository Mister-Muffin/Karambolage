extends Control

export (int) var slotNumber

const health = 20

var currHealthPacks = 0

var hasItem = true

func _ready():
	$number.text = String(slotNumber)
	set_process(true)


func _on_btn_button_down():
	if hasItem && GLOBALS.health <= 100 - health && not $container/item.texture == null:
		hasItem = false
		$animPlayer.play_backwards("anim")
		GLOBALS.health = GLOBALS.health + health

func _process(delta):
	if currHealthPacks < INVENTORY.healthPacks:
		hasItem = true
		$animPlayer.play("anim")
		currHealthPacks = INVENTORY.healthPacks
	if Input.is_action_just_pressed(String(slotNumber)):
		if hasItem && not $container/item.texture == null:
			hasItem = false
			$animPlayer.play_backwards("anim")
			GLOBALS.health = GLOBALS.health + health
			if GLOBALS.health > 100: GLOBALS.health = 100
