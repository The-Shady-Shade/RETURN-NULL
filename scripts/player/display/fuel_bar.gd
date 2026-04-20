extends ProgressBar

func _process(_delta: float) -> void:
	value = GameManager.spaceship.fuel
