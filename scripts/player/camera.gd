extends Camera3D

@export_group("Shake Stats")
@export var noise_texture: NoiseTexture2D
@export var noise_spd: float = 50.0
@export var trauma_reduction_rate: float = 1.0
@export var rotation_max: Vector3 = Vector3(10.0, 10.0, 5.0)
@onready var initial_rotation: Vector3 = rotation_degrees
var trauma: float = 0.0
var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	trauma = max(trauma - trauma_reduction_rate * delta, 0.0)
	rotation_degrees.x = initial_rotation.x + rotation_max.x * get_shake_intensity() * get_noise_from_seed(0)
	rotation_degrees.y = initial_rotation.y + rotation_max.y * get_shake_intensity() * get_noise_from_seed(1)
	rotation_degrees.z = initial_rotation.z + rotation_max.z * get_shake_intensity() * get_noise_from_seed(2)

func add_trauma(trauma_amount: float) -> void:
	if !GameManager.camera_shake: return
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(idx: int) -> float:
	noise_texture.noise.seed = idx
	return noise_texture.noise.get_noise_1d(time * noise_spd)
