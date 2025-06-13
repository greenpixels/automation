extends Node2D

func _process(delta: float) -> void:
	$Camera2D.zoom = $Camera2D.zoom.move_toward(Vector2.ONE * 0.75, delta / 10.)
