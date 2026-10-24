extends Area2D

# State Machine
enum ghostState {FOCUS, POSSESS}
var currentState

# Grid Variables
@export_category("Grid Variables")
@export var offset = 128

# movement variables
@export_category("Movement Variables")
var can_move = true
var ghost_position: Vector2 = Vector2(192, 192)

func _ready() -> void:
	currentState = ghostState.FOCUS

func _input(event: InputEvent) -> void:
	if currentState == ghostState.FOCUS:
		if event.is_action_pressed("left") && can_move:
			_move_ghost(_grid_to_pixel(-1, 0))
		if event.is_action_pressed("right") && can_move:
			_move_ghost(_grid_to_pixel(1, 0))
		if event.is_action_pressed("up") && can_move:
			_move_ghost(_grid_to_pixel(0, -1))
		if event.is_action_pressed("down") && can_move:
			_move_ghost(_grid_to_pixel(0, 1))

func _move_ghost(target_pos: Vector2):
	var move_pos = ghost_position + target_pos
	can_move = false
	ghost_position += target_pos
	var tween = create_tween()
	
	tween.tween_property(self, "position", ghost_position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(0.3).timeout
	can_move = true

func _grid_to_pixel(x: int, y: int) -> Vector2:
	return Vector2(offset * x, offset * y)
