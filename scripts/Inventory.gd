extends Node

var healthPacks = 0

func add_item(var type : String):
	if type == "health":
		healthPacks = healthPacks + 1