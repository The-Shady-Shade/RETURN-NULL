extends Camera3D
signal finished

var current_camera: Camera3D = null
var transitioning: bool = false

func switch_camera(from: Camera3D, to: Camera3D, duration: float = 1.0) -> void:
	if transitioning:
		return
	
	fov = from.fov
	size = from.size
	global_transform = from.global_transform
	
	current = true
	transitioning = true
	get_tree().get_root().set_disable_input(true)
	
	var tween: Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_transform", to.global_transform, duration)
	tween.parallel().tween_property(self, "fov", to.fov, duration)
	tween.parallel().tween_property(self, "size", to.size, duration)
	tween.play()
	
	await tween.finished
	to.current = true
	current_camera = to
	transitioning = false
	get_tree().get_root().set_disable_input(false)
	finished.emit()
