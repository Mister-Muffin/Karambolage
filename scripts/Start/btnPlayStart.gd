extends Button

func _ready():
	pass


func _on_button_pressed():
	get_tree().change_scene("res://scenes/Level.tscn")
