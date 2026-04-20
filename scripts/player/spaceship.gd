class_name SpaceShip extends CharacterBody3D
@warning_ignore("unused_signal")
signal new_status(status: StringName)
signal got_damage

@export_category("Movement")
@export_group("Position")
@export_subgroup("Throttle")
@export var base_throttle_max: float = 20.0
var throttle_max: float = base_throttle_max
@export var throttle_acc: float = 2.5
var throttle: float = 0.0
@export_subgroup("Strafe")
@export var strafe_marker: Marker3D
@export var strafe_spd_max: float = 25.0
@export var strafe_acc: float = 2.5
var strafe_velocity: Vector3 = Vector3.ZERO
@export_subgroup("Boost")
@export var boost_sound: AudioStreamPlayer
@export var boosted_throttle_max: float = 40.0
@export var boost_time_max: float = 2.0
@export var boost_fuel_cost: float = 5.0
var boost_time: float = 0.0
@export_group("Rotation")
@export var camera: Camera3D
@export var mouse_control: Control
@export var pitch_spd: float = 1.5
@export var yaw_spd: float = 1.5
@export var roll_spd: float = 0.5
@export var mouse_threshold: float = 50.0
var relative_mouse: Vector2 = Vector2.ZERO
var roll_dir: float = 0.0
@export_category("Survival")
@export_file("*.tscn") var main_menu_path: String
var dead: bool = false
@export_group("HP")
@export var damage_sound: AudioStreamPlayer
@export var out_of_hp_sound: AudioStreamPlayer
@export var hp_max: float = 100.0
var hp: float = hp_max
@export var get_damage_cd_max: float = 2.0
var get_damage_cd: float = 0.0
@export var asteroid_collide_dmg: float = 10.0
@export_group("Fuel")
@export var display_manager: DisplayManager
@export var out_of_fuel_sound: AudioStreamPlayer
@export var fuel_max: float = 100.0
var fuel: float = fuel_max

func _ready() -> void:
	GameManager.spaceship = self
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	get_damage_cd = max(0.0, get_damage_cd - delta)
	
	if Input.is_action_just_pressed("boost") && (Input.is_action_pressed("throttle_up") || Input.is_action_pressed("throttle_down")) && throttle_max == base_throttle_max:
		throttle_max = boosted_throttle_max
		fuel -= boost_fuel_cost
		camera.add_trauma(0.5)
		boost_sound.play()
	if throttle_max == boosted_throttle_max:
		boost_time += delta
		if boost_time >= boost_time_max:
			boost_time = 0.0
			throttle_max = base_throttle_max
	
	fuel -= delta
	if fuel <= 0.0 && !dead:
		dead = true
		display_manager.queue_free()
		out_of_fuel_sound.play()
		await get_tree().create_timer(2.0).timeout
		SceneTransition.change_scene(main_menu_path)

func _physics_process(delta: float) -> void:
	if !dead:
		relative_mouse = get_relative_mouse()
		roll_dir = Input.get_axis("roll_right", "roll_left")
	
	basis = basis.rotated(basis.x, -relative_mouse.y * (-1 if GameManager.inverse_x_axis else 1) * PI * pitch_spd * delta) # Pitch
	basis = basis.rotated(basis.y, -relative_mouse.x * (-1 if GameManager.inverse_y_axis else 1) * PI * yaw_spd * delta) # Yaw
	basis = basis.rotated(basis.z, roll_dir * PI * roll_spd * delta)
	basis = basis.orthonormalized()
	
	for idx: int in get_slide_collision_count():
		var collision: KinematicCollision3D = get_slide_collision(idx)
		if collision.get_collider() is GridMap:
			get_damage(asteroid_collide_dmg)
	
	if dead:
		move_and_slide()
		return
	
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
	if get_damage_cd > 0.0: return
	
	hp -= dmg
	damage_sound.play()
	camera.add_trauma(0.75)
	
	if dmg == asteroid_collide_dmg:
		velocity += basis.z * 100.0
	
	if hp <= 0.0 && !dead:
		dead = true
		display_manager.queue_free()
		out_of_hp_sound.play()
		await get_tree().create_timer(2.0).timeout
		SceneTransition.change_scene(main_menu_path)

	get_damage_cd = get_damage_cd_max
	got_damage.emit()
