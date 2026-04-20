extends Node3D

@export var target: Camera3D
@export var update_position: bool = false
@export var update_rotation: bool = true
@export var physics_update_position: bool = false
@export var physics_update_rotation: bool = false
@export var deffered_update: bool = true

func _process(_delta: float) -> void:
	if !physics_update_position || !physics_update_rotation:
		if deffered_update:
			Callable(update.bind(false)).call_deferred()
		else:
			update(false)

func _physics_process(_delta: float) -> void:
	if physics_update_position || physics_update_rotation:
		if deffered_update:
			Callable(update.bind(true)).call_deferred()
		else:
			update(true)

func update(physics: bool) -> void:
	if update_position && physics_update_position == physics:
		global_position = target.global_position
	if update_rotation && physics_update_rotation == physics:
		global_rotation = target.global_rotation
