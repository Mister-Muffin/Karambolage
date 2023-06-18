extends Control

var entered = false

func _ready():
	set_process(true)

func _process(delta):
	if get_node("../../../../Main").visible: visible = true
	else: visible = false
