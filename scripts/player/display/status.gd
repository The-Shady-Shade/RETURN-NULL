extends Control

@export var animation: AnimationPlayer

func _ready() -> void:
	await get_tree().process_frame
	GameManager.spaceship.new_status.connect(update_status)

func update_status(status: String = "Calm") -> void:
	animation.play(status)
