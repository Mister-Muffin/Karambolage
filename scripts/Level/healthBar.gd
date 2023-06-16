extends ProgressBar

@export_range(1, 2) var player: int = 1

var health = 100
var colorChanged = false

var tween: Tween
var moveTween: Tween

func _ready():
	GLOBALS.change_health.connect(_health_changed)
	GLOBALS.p2_join.connect(_on_p2_joined)

func move():
	if moveTween: moveTween.kill()
	moveTween = get_tree().create_tween()
	moveTween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	if player == 1:
		moveTween.tween_property(self, "position", Vector2(130, get("position").y), 0.5)
	else:
		moveTween.tween_property(self, "position", Vector2(990, get("position").y), 0.5)

func _health_changed(val, player):
	if player != self.player: return
	health += val

	if health <= 20 && not colorChanged:
		$AnimationPlayer.play("changeColor")
		colorChanged = true
	if health > 20 && colorChanged:
		$AnimationPlayer.play_backwards("changeColor")
		colorChanged = false

	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "value", health, 0.5)

func _on_p2_joined():
	move()
