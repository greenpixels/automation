extends Node2D

enum Type {
	ITEM,
	FURNACE
}

static var draw_index = {
	Type.ITEM: 0,
	Type.FURNACE: 0
}

@export var item_renderer : MultiMeshInstance2D
@export var furnace_renderer : MultiMeshInstance2D

var _should_reset_draw_progress = true

func _process(_delta: float) -> void:
	set_deferred("_should_reset_draw_progress", true)

func set_mesh_transform_for(target_transform: Transform2D, type: Type):
	if _should_reset_draw_progress:
		_should_reset_draw_progress = false
		draw_index = {
			Type.ITEM: 0,
			Type.FURNACE: 0
		}
		# Since we render every item at once, we can set the visible-count dynamically
		item_renderer.multimesh.visible_instance_count = 0
	match(type):
		Type.ITEM:
			item_renderer.multimesh.visible_instance_count += 1
			item_renderer.multimesh.set_instance_transform_2d(draw_index[type], target_transform)
		Type.FURNACE:
			furnace_renderer.multimesh.set_instance_transform_2d(draw_index[type], target_transform)
	draw_index[type] += 1
