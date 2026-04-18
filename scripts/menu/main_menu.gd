extends Control

@export_file("*.tscn") var intro_path: String
@export_file("*.tscn") var settings_menu_path: String

func _on_play_button_pressed() -> void:
	SceneTransition.change_scene(intro_path)

func _on_settings_button_pressed() -> void:
	SceneTransition.change_scene(settings_menu_path)
