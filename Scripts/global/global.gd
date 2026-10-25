extends Node

func move_to(object: Node, move_amount: Vector2):
	if object.has_method("check_move"):
		if not object.check_move(move_amount):
			return
	
	object.can_move = false
	object.object_position += move_amount
	var tween = create_tween()
	
	tween.tween_property(object, "position", object.object_position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	object.can_move = true

func _grid_to_pixel(offset: int, x: int, y: int) -> Vector2:
	return Vector2(offset * x, offset * y)
