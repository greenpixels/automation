extends Node2D


@export var tile_map_layer: TileMapLayer
@export var placeable: Placeable:
	set(value):
		placeable = value
		placeable_rotation = 0
		is_placeable_vertically_flipped = false
		if not placeable:
			placeable_preview.hide()
		else:
			placeable_preview.texture = placeable.texture
			placeable_preview.show()

@export var placeable_rotation: int = 0:
	set(value):
		placeable_rotation = value
		placeable_preview.rotation = deg_to_rad(placeable_rotation)

@export var is_placeable_vertically_flipped: bool = false:
	set(value):
		is_placeable_vertically_flipped = value
		placeable_preview.scale.y = -1 if is_placeable_vertically_flipped else 1

@onready var placeable_preview: Sprite2D = $PlaceablePreview

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		placeable_preview.global_position = WorldGrid.get_world_grid_coordinate_to_global(
			WorldGrid.get_global_to_world_grid_coordinate(event.global_position)
		)
	elif event is InputEventKey and event.is_released() and placeable:
		if event.is_action("rotate_placeable") and placeable.can_be_rotated:
			placeable_rotation += 90
		elif event.is_action("flip_placeable") and placeable.can_be_flipped:
			is_placeable_vertically_flipped = !is_placeable_vertically_flipped
	elif event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			_place_object_at(WorldGrid.get_global_to_world_grid_coordinate(event.global_position))
		elif event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			WorldGrid.remove_object_at(
				WorldGrid.get_global_to_world_grid_coordinate(event.global_position)
			)

func _place_object_at(coords: Vector2):
	if not placeable or not placeable.scene:
		return
	var object = placeable.scene.instantiate()
	object.global_position = WorldGrid.get_world_grid_coordinate_to_global(coords)
	object.scale.y = -1 if is_placeable_vertically_flipped else 1
	object.rotation = placeable_preview.rotation
	WorldGrid.add_child(object)

func set_placeable(new_placeable: Placeable):
	if placeable == new_placeable:
		return
	placeable = new_placeable
