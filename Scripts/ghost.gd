extends Area2D

@onready var spr: Sprite2D = $Sprite2D

# State Machine
enum ghostState {FOCUS, POSSESS}
var currentState

# Grid Variables
@export_category("Grid Variables")
@export var offset = 128
@export var object_position: Vector2 = Vector2(320, 320)

# movement variables
@export_category("Movement Variables")
var can_move = true
var can_move_left = true
var can_move_right = true
var can_move_top = true
var can_move_bottom = true

# possession variables
var can_possess = false
var object_to_possess : Node = null

func _ready() -> void:
	object_position = position
	currentState = ghostState.FOCUS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		match currentState:
			ghostState.FOCUS:
				print("Hello!", can_possess)
				if can_possess:
					possess_host()
			ghostState.POSSESS:
				leave_host()
	if currentState == ghostState.FOCUS:
		if event.is_action_pressed("left") && can_move && can_move_left:
			spr.frame = 1
			Global.move_to(self, Global._grid_to_pixel(offset, -1, 0))
		if event.is_action_pressed("right") && can_move && can_move_right:
			spr.frame = 3
			Global.move_to(self, Global._grid_to_pixel(offset, 1, 0))
		if event.is_action_pressed("up") && can_move && can_move_top:
			spr.frame = 2
			Global.move_to(self, Global._grid_to_pixel(offset, 0, -1))
		if event.is_action_pressed("down") && can_move && can_move_bottom:
			spr.frame = 0
			Global.move_to(self, Global._grid_to_pixel(offset, 0, 1))

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

func _on_ghost_base_area_entered(area: Area2D) -> void:
	if area.is_in_group("Possessables"):
		can_possess = true
		if area.has_method("unposses"):
			object_to_possess  = area
		else:
			object_to_possess = area.get_parent()

func _on_ghost_base_area_exited(area: Area2D) -> void:
	if area.is_in_group("Possessables") and (area == object_to_possess or area.get_parent() == object_to_possess):
		can_possess = false

func possess_host():
	currentState = ghostState.POSSESS
	visible = false
	object_to_possess.currentState = object_to_possess.moveState.FOCUS
	if object_to_possess.has_method("possess"):
		object_to_possess.possess()

func leave_host():
	if object_to_possess.has_method("unposses"):
		object_to_possess.unposses()
	
	currentState = ghostState.FOCUS
	position = object_to_possess.position
	object_position = object_to_possess.object_position
	visible = true
	object_to_possess.currentState = object_to_possess.moveState.DEAD
