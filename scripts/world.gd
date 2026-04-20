extends Node3D

@export var soundtrack_player: AudioStreamPlayer

func _process(_delta: float) -> void:
	if !soundtrack_player.playing:
		soundtrack_player.play()
