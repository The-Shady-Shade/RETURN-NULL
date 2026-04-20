extends StaticBody3D

@export var signal_area: Area3D
@export var mesh_instance: MeshInstance3D
@export var icon_component: Node3D
var word: String = "NEBULA"
var active: bool = true

func _physics_process(_delta: float) -> void:
	if signal_area.has_overlapping_bodies() && Input.is_action_just_pressed("interact"):
		var idx: int = randi_range(0, word.length() - 1)
		while GameManager.letters.has(word[idx]):
			idx = randi_range(0, word.length() - 1)
		GameManager.spaceship.fuel -= 10.0
		GameManager.new_letter.emit(word[idx])
		deactivate()

func deactivate() -> void:
	GameManager.spaceship.new_status.emit("Calm")
	signal_area.queue_free()
	mesh_instance.set_surface_override_material(1, mesh_instance.get_active_material(0))
	icon_component.queue_free()
	set_process(false)
	set_physics_process(false)

func _on_signal_area_body_entered(_body: Node3D) -> void:
	GameManager.spaceship.new_status.emit("Signal")

func _on_signal_area_body_exited(_body: Node3D) -> void:
	GameManager.spaceship.new_status.emit("Calm")
