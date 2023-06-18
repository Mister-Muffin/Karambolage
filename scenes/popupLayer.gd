extends CanvasLayer

func showPopup(text):
	hideLight()
	$confDialog.dialog_text = text
	$animPlayer.play("zoom")
	GLOBALS.popupShown = true

func closePopup():
	$animPlayer.play_backwards("zoom")
	GLOBALS.popupShown = false

func _on_confDialog_visibility_changed():
	print("Popup visibility changed")
	print($confDialog.visible)
	print("--------------")
	if($confDialog.visible):
		print()
	elif(GLOBALS.popupShown):
		GLOBALS.popupShown = false
		showLight()

func hideLight():
	if GLOBALS.cave:
		$"../canvasLayerPause/colorRectPause".color.a = 255
		if($"../canvasLayerPause/colorRectPause".color.a == 255):
			$"../PointLight2D".visible = false
		else:
			hideLight()

func showLight():
	if GLOBALS.cave:
		$"../PointLight2D".visible = true
		$"../canvasLayerPause/colorRectPause".color.a = 200
