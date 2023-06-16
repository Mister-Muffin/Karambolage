extends ColorRect

var tween: Tween

var gameEnding := false

func _ready() -> void:
	GLOBALS.end_game.connect(_on_game_end)

func _on_game_end():
	if gameEnding: return
	gameEnding = true
	var endPos = Vector2(self.get_global_rect().position.x, 0)
	if not GLOBALS.cave:
		if tween: tween.kill()
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", endPos, 1.5)
		tween.tween_callback(tween_callback)

var tween_callback = func():
	await get_tree().create_timer(0.5).timeout
	_quit()

func _quit():
	get_tree().change_scene_to_file("res://scenes/Start.tscn")
