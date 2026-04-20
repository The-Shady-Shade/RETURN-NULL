extends StaticBody3D

@export var refuel_sound: AudioStreamPlayer
@export var rotation_spd: float = 0.5
var rotation_dir: Vector3 = Vector3.ZERO

func _ready() -> void:
	rotation_dir = Vector3i(randi_range(-1, 1), randi_range(-1, 1), randi_range(-1, 1))

func _physics_process(delta: float) -> void:
	rotation += rotation_dir * PI * rotation_spd * delta

func _on_fuel_area_body_entered(_body: Node3D) -> void:
	if visible:
		visible = false
		GameManager.spaceship.fuel = GameManager.spaceship.fuel_max
		GameManager.spaceship.camera.add_trauma(0.35)
		refuel_sound.play()
		await refuel_sound.finished
		queue_free()
