extends Control

@export var speed_label: Label
@export var speed_bar: TextureProgressBar

func _process(_delta: float) -> void:
	speed_label.text = str(roundf(GameManager.spaceship.velocity.length() * 5.0)) + " m/s"
	speed_bar.value = roundf(GameManager.spaceship.velocity.length() * 5.0)
