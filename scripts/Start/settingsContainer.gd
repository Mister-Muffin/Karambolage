extends VBoxContainer

func _ready():
	$closeConfirmationCheck.pressed = GLOBALS.closeConfirmation


func _on_closeConfirmationCheck_toggled(button_pressed):
	GLOBALS.closeConfirmation = $closeConfirmationCheck.pressed