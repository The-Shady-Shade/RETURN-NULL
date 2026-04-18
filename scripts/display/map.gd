extends Control

@export var map_texture: TextureRect

func _ready() -> void:
	var viewport: SubViewport = SceneTransition.current_scene.get_node("MapViewport")
	viewport.size = size
	map_texture.texture = viewport.get_texture()
