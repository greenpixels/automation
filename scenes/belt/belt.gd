extends Node2D
class_name Belt

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@export var item_direction: Vector2i = Vector2i.ZERO
@export var slots : PackedFloat32Array = [-1, -1, -1, -1, -1]

func add_item(item: Item):
	item.belt = self
	item.belt_position_index = 0
	slots[item.belt_position_index] = item.item_id
	position_item(item)
	
func remove_item(item: Item):
	slots[item.belt_position_index] = -1
	item.belt_position_index = 0

func move_item_on_belt(item: Item):
	if not (item.belt_position_index >= slots.size() - 1 or not is_equal_approx(slots[item.belt_position_index + 1], -1)):
		if item.belt_position_index >= 0: slots[item.belt_position_index] = -1
		item.belt_position_index += 1
		slots[item.belt_position_index] = item.item_id
		position_item(item)
	
func position_item(item: Item):
	path_follow.progress_ratio = float(item.belt_position_index) / float(slots.size())
	# item.rotation = (item.global_position - path_follow.global_position).round().normalized().angle()
	item.global_position = path_follow.global_position

func can_take_new_item():
	return is_equal_approx(slots[0], -1)
