extends ProgressBar

@export_range(1, 2) var player: int = 1

@onready var timer = $regenerationTimer

var energy := 100

var tween: Tween
var moveTween: Tween

func _ready():
	GLOBALS.change_energy.connect(_energy_changed)
	GLOBALS.p2_join.connect(_on_p2_joined)

func move():
	if moveTween: moveTween.kill()
	moveTween = get_tree().create_tween()
	moveTween.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	if player == 1:
		moveTween.tween_property(self, "position", Vector2(130, get("position").y), 0.5)
	else:
		moveTween.tween_property(self, "position", Vector2(990, get("position").y), 0.5)

func _energy_changed(val, player):
	if player != self.player: return
	energy += val
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "value", energy, 0.2)

func _on_p2_joined():
	move()
