extends ProgressBar

func _ready() -> void:
	await get_tree().process_frame
	GameManager.spaceship.got_damage.connect(update_progress_bar)

func update_progress_bar() -> void:
	value = GameManager.spaceship.hp
