extends VBoxContainer

@onready var enemyLabel = $totalEnemysLabel
@onready var fpsLabel = $labelFPS

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	enemyLabel.text = "Enemies: " + str(GLOBALS.enemys)
	fpsLabel.text = "FPS: " + str(Engine.get_frames_per_second())
	await get_tree().create_timer(0.1).timeout
