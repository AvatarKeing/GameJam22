extends Area2D

# State Machine
enum ghostState {FOCUS, POSSESS}
var currentState

# Grid Variables
@export_category("Grid Variables")
@export var offset = 128
@export var ghost_position: Vector2 = Vector2(320, 320)

# movement variables
@export_category("Movement Variables")
var can_move = true
var can_move_left = true
var can_move_right = true
var can_move_top = true
var can_move_bottom = true

# possession variables
var can_possess = false
var object_to_possess = null

func _ready() -> void:
	currentState = ghostState.FOCUS

func _input(event: InputEvent) -> void:
	if currentState == ghostState.FOCUS:
		if event.is_action_pressed("left") && can_move && can_move_left:
			_move_ghost(_grid_to_pixel(-1, 0))
		if event.is_action_pressed("right") && can_move && can_move_right:
			_move_ghost(_grid_to_pixel(1, 0))
		if event.is_action_pressed("up") && can_move && can_move_top:
			_move_ghost(_grid_to_pixel(0, -1))
		if event.is_action_pressed("down") && can_move && can_move_bottom:
			_move_ghost(_grid_to_pixel(0, 1))
		if event.is_action_pressed("interact") && can_possess:
			object_to_possess.currentState = object_to_possess.moveState.FOCUS
			object_to_possess.possessor = self
			visible = false
			currentState = ghostState.POSSESS

func _move_ghost(target_pos: Vector2):
	can_move = false
	ghost_position += target_pos
	var tween = create_tween()
	
	tween.tween_property(self, "position", ghost_position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	can_move = true

func _grid_to_pixel(x: int, y: int) -> Vector2:
	return Vector2(offset * x, offset * y)

func _on_top_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_top = false

func _on_top_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_top = true

func _on_bottom_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_bottom = false

func _on_bottom_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_bottom = true

func _on_left_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_left = false

func _on_left_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_left = true

func _on_right_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_right = false

func _on_right_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border"):
		can_move_right = true

func _on_ghost_enter(area: Area2D) -> void:
	if area.is_in_group("Possessables"):
		can_possess = true
		object_to_possess = area

func _on_ghost_exit(area: Area2D) -> void:
	if area.is_in_group("Possessables"):
		can_possess = false
		object_to_possess = null
