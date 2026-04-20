extends Control

@export var map_texture: TextureRect

func _ready() -> void:
	await get_tree().process_frame
	var viewport: SubViewport = get_tree().current_scene.get_node("MapViewport")
	viewport.size = size
	map_texture.texture = viewport.get_texture()
