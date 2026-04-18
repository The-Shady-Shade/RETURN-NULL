class_name SpaceShip extends CharacterBody3D

@export_category("Movement")
@export_group("Position")
@export_subgroup("Throttle")
@export var throttle_max: float = 5.0
@export var throttle_acc: float = 2.5
var throttle: float = 0.0
@export_subgroup("Strafe")
@export var strafe_marker: Marker3D
@export var strafe_spd_max: float = 25.0
@export var strafe_acc: float = 2.5
var strafe_velocity: Vector3 = Vector3.ZERO
@export_group("Rotation")
@export var camera: Camera3D
@export var mouse_control: Control
@export var pitch_spd: float = 1.5
@export var yaw_spd: float = 1.5
@export var roll_spd: float = 0.5
@export var mouse_threshold: float = 50.0
@export_category("Battle")
@export var hp_max: float = 100.0
var hp: float = hp_max

func _ready() -> void:
	GameManager.spaceship = self
	CameraTransition.current_camera = camera
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	
	var relative_mouse: Vector2 = get_relative_mouse()
	basis = basis.rotated(basis.x, -relative_mouse.y * (-1 if GameManager.inverse_x_axis else 1) * PI * pitch_spd * delta) # Pitch
	basis = basis.rotated(basis.y, -relative_mouse.x * (-1 if GameManager.inverse_y_axis else 1) * PI * yaw_spd * delta) # Yaw
	basis = basis.rotated(basis.z, Input.get_axis("roll_right", "roll_left") * PI * roll_spd * delta)
	basis = basis.orthonormalized()
	
	var dir: Vector3 = -basis.z
	throttle = lerp(throttle, throttle_max * Input.get_axis("throttle_down", "throttle_up"), throttle_acc * delta)
	velocity = dir * throttle
	
	var strafe_input: Vector2 = Input.get_vector("strafe_left", "strafe_right", "strafe_down", "strafe_up")
	strafe_marker.position = Vector3(strafe_input.x, strafe_input.y, 0.0)
	var strafe_dir: Vector3 = strafe_marker.global_position - global_position
	strafe_velocity = lerp(strafe_velocity, strafe_spd_max * strafe_dir, strafe_acc * delta)
	velocity += strafe_velocity
	
	move_and_slide()

func get_relative_mouse() -> Vector2:
	var viewport: Viewport = get_viewport()
	var mouse_dir: Vector2 = viewport.get_mouse_position() - viewport.size * 0.5
	if mouse_dir.length() < mouse_threshold:
		return Vector2.ZERO
	var size: float = max(viewport.size.x, viewport.size.y)
	return mouse_dir / size

func get_damage(dmg: float) -> void:
	hp -= dmg
	if hp <= 0.0:
		pass
