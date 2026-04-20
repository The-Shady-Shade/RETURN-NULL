extends Control

@export_file("*.tscn") var main_menu_path: String
@export_group("Controls")
@export var camera_shake_checkbox: CheckBox
@export var invert_x_axis_checkbox: CheckBox
@export var invert_y_axis_checkbox: CheckBox
@export_group("Volume")
@export var master_slider: HSlider
@export var soundtrack_slider: HSlider
@export var sfx_slider: HSlider

func _enter_tree() -> void:
	camera_shake_checkbox.button_pressed = GameManager.camera_shake
	invert_x_axis_checkbox.button_pressed = GameManager.inverse_x_axis
	invert_y_axis_checkbox.button_pressed = GameManager.inverse_y_axis
	master_slider.value = get_bus_volume("Master") * 100.0
	soundtrack_slider.value = get_bus_volume("Soundtrack") * 100.0
	sfx_slider.value = get_bus_volume("SFX") * 100.0

func set_bus_volume(bus_name: String, volume: float) -> void:
	var bus_idx: int = AudioServer.get_bus_index(bus_name)
	
	if volume == 0.0:
		AudioServer.set_bus_mute(bus_idx, true)
		return
	else:
		AudioServer.set_bus_mute(bus_idx, false)
	
	if volume == 1.0:
		AudioServer.set_bus_volume_db(bus_idx, 0.0)
		return
	
	AudioServer.set_bus_volume_db(bus_idx, -1.0 / volume)

func get_bus_volume(bus_name: String) -> float:
	var bus_idx: int = AudioServer.get_bus_index(bus_name)
	var bus_volume_db: float = AudioServer.get_bus_volume_db(bus_idx)
	if bus_volume_db == 0.0:
		return 1.0
	return -1.0 / bus_volume_db

func _on_camera_shake_check_box_toggled(toggled_on: bool) -> void:
	GameManager.camera_shake = toggled_on

func _on_invert_x_axis_check_box_toggled(toggled_on: bool) -> void:
	GameManager.inverse_x_axis = toggled_on

func _on_invert_y_axis_check_box_toggled(toggled_on: bool) -> void:
	GameManager.inverse_y_axis = toggled_on

func _on_master_slider_drag_ended(_value_changed: bool) -> void:
	set_bus_volume("Master",  master_slider.value / 100)

func _on_soundtrack_slider_drag_ended(_value_changed: bool) -> void:
	set_bus_volume("Soundtrack",  soundtrack_slider.value / 100)

func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	set_bus_volume("SFX",  sfx_slider.value / 100)

func _on_back_button_pressed() -> void:
	SceneTransition.change_scene(main_menu_path)
