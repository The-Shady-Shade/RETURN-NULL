extends Control

@export var speed_label: Label
@export var speed_bar: TextureProgressBar
@export var animation: AnimationPlayer

func _process(_delta: float) -> void:
	speed_label.text = str(roundf(GameManager.spaceship.velocity.length() * 5.0)) + " M/S"
	speed_bar.value = roundf(GameManager.spaceship.velocity.length() * 5.0)
	if GameManager.spaceship.fuel <= 25.0:
		animation.play("Ping")
	else:
		animation.play("RESET")
