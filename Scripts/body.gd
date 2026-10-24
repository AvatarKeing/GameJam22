extends Area2D

# State Machine
enum moveState {DEAD, FOCUS}
var currentState
var possessor

# Grid Variables
@export_category("Grid Variables")
@export var offset = 128
@export var body_position: Vector2 = Vector2(832, 320)

# movement variables
@export_category("Movement Variables")
var can_move = true
var can_move_left = true
var can_move_right = true
var can_move_top = true
var can_move_bottom = true

func _ready() -> void:
	currentState = moveState.DEAD
	
func _process(delta) -> void:
	if currentState == moveState.FOCUS:
		print("AHHHHH")

func _input(event: InputEvent) -> void:
	if currentState == moveState.FOCUS:
		if event.is_action_pressed("left") && can_move && can_move_left:
			_move_ghost(_grid_to_pixel(-1, 0))
		if event.is_action_pressed("right") && can_move && can_move_right:
			_move_ghost(_grid_to_pixel(1, 0))
		if event.is_action_pressed("up") && can_move && can_move_top:
			_move_ghost(_grid_to_pixel(0, -1))
		if event.is_action_pressed("down") && can_move && can_move_bottom:
			_move_ghost(_grid_to_pixel(0, 1))
		if event.is_action_pressed("interact"):
			possessor.currentState = possessor.ghostState.FOCUS
			possessor.position = position
			possessor.ghost_position = body_position
			possessor.visible = true
			currentState = moveState.DEAD

func _move_ghost(target_pos: Vector2):
	var move_pos = body_position + target_pos
	can_move = false
	body_position += target_pos
	var tween = create_tween()
	
	tween.tween_property(self, "position", body_position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	can_move = true

func _grid_to_pixel(x: int, y: int) -> Vector2:
	return Vector2(offset * x, offset * y)
