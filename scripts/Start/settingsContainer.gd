extends VBoxContainer

func _ready():
	await get_tree().idle_frame
	$closeConfirmationCheck.button_pressed = GLOBALS.closeConfirmation


func _on_closeConfirmationCheck_toggled(button_pressed):
	GLOBALS.closeConfirmation = $closeConfirmationCheck.pressed
	SETTINGS.set_setting("settings", "closeConf", GLOBALS.closeConfirmation)
	SETTINGS.save_settings()