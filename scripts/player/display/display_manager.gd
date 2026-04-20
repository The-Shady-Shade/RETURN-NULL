class_name DisplayManager extends Node3D

@export var displays: Dictionary[MeshInstance3D, PackedScene]

func _ready() -> void:
	for display: MeshInstance3D in displays.keys():
		if !display:
			continue
		
		var viewport: SubViewport = SubViewport.new()
		viewport.size = Vector2(640.0, 480.0)
		viewport.canvas_item_default_texture_filter = Viewport.DefaultCanvasItemTextureFilter.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
		viewport.gui_embed_subwindows = true
		add_child(viewport)
		
		var interface: Control = displays[display].instantiate()
		viewport.size = interface.size
		viewport.add_child(interface)
		
		var display_material: StandardMaterial3D = StandardMaterial3D.new()
		display_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		display_material.albedo_texture = viewport.get_texture()
		display_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
		display.material_override = display_material
