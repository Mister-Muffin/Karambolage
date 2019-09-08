extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
			$"../Light2D".visible = false
		else:
			hideLight()
	
func showLight():
	if GLOBALS.cave:
		$"../Light2D".visible = true
		$"../canvasLayerPause/colorRectPause".color.a = 200