extends Label

var time = 0

func _ready():
	set_process(true)

func _process(delta):
	text = String(time)


func _on_Timer_timeout():
	time = time + 1
