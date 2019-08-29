extends Node

var healthPacks = 0
var newHealthPack = false

var gun = false
var gunAmo = 100

func add_item(var type : String):
	if type == "health":
		newHealthPack = true