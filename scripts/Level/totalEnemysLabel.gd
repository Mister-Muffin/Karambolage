extends Label

func _ready():
	set_process(true)

func _process(delta):
	text = "Enemies: " + String(GLOBALS.enemys)