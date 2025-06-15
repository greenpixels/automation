extends Node

@export var main_object: Node2D
@export var id: int


func _ready() -> void:
	var world_id = WorldGrid.place_object(main_object)
	if world_id == null:
		main_object.queue_free()
		return
	id = world_id
