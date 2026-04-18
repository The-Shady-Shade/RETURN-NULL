extends Node3D

@export var sprite: Sprite3D
@export var icon: Texture

func _ready() -> void:
	sprite.texture = icon
	
