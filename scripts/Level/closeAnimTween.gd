extends ColorRect
var tween: Tween

func _ready():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func _on_player_end_game():
	var endPos = Vector2(self.get_global_rect().position.x, 0)
	if not GLOBALS.cave:
		tween.tween_property(self, "position", endPos, 1.5)
		tween.tween_callback(await _tween_callback())

func _tween_callback():
	await get_tree().create_timer(0.5).timeout
	_quit()

func _quit():
	get_tree().change_scene_to_file("res://scenes/Start.tscn")
