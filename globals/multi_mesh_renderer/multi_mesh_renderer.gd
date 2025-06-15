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

var _should_reset_draw_progress = false

func _process(delta: float) -> void:
	set_deferred("_should_reset_draw_progress", true)

func set_mesh_transform_for(transform: Transform2D, type: Type):
	if _should_reset_draw_progress:
		_should_reset_draw_progress = false
		draw_index = {
			Type.ITEM: 0,
			Type.FURNACE: 0
		}
	match(type):
		Type.ITEM:
			item_renderer.multimesh.set_instance_transform_2d(draw_index[type], transform)
		Type.FURNACE:
			furnace_renderer.multimesh.set_instance_transform_2d(draw_index[type], transform)
	draw_index[type] += 1
