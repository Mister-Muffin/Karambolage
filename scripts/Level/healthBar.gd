extends ProgressBar

var player: int = 1

var health = 100

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

func _health_changed(val, p):
	if p != player: return
	var prev_health = health
	health += val

	if health <= 20 and prev_health > 20:
		$AnimationPlayer.play("green_red")
	if health > 20 and prev_health <= 20:
		$AnimationPlayer.play_backwards("green_red")

	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "value", health, 0.5)

func _on_p2_joined():
	move()
