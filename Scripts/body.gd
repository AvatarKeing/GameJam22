extends Area2D

@onready var NormalSpr: Sprite2D = $NormalSprite
@onready var StatueSpr: Sprite2D = $StatueSprite


# State Machine
enum moveState {DEAD, FOCUS}
var currentState
var possessor

# Grid Variables
@export_category("Grid Variables")
@export var offset = 128
@export var object_position: Vector2 = Vector2(832, 320)

# movement variables
@export_category("Movement Variables")
var can_move = true
var can_move_left = true
var can_move_right = true
var can_move_top = true
var can_move_bottom = true

func _ready() -> void:
	object_position = position
	currentState = moveState.DEAD

func _process(_delta: float) -> void:
	match currentState:
		moveState.FOCUS:
			NormalSpr.visible = true
			StatueSpr.visible = false
		moveState.DEAD:
			NormalSpr.visible = false
			StatueSpr.visible = true
			
var last_move_time : float = -1000.0

func _input(event: InputEvent) -> void:
	if Time.get_ticks_msec() < last_move_time + .2:
		return
	
	if currentState == moveState.FOCUS:
		if event.is_action_pressed("left") && can_move && can_move_left:
			NormalSpr.frame = 1
			StatueSpr.frame = 1
			Global.move_to(self, Global._grid_to_pixel(offset, -1, 0))
			last_move_time = Time.get_ticks_msec()
		if event.is_action_pressed("right") && can_move && can_move_right:
			NormalSpr.frame = 3
			StatueSpr.frame = 3
			Global.move_to(self, Global._grid_to_pixel(offset, 1, 0))
			last_move_time = Time.get_ticks_msec()
		if event.is_action_pressed("up") && can_move && can_move_top:
			NormalSpr.frame = 2
			StatueSpr.frame = 2
			Global.move_to(self, Global._grid_to_pixel(offset, 0, -1))
			last_move_time = Time.get_ticks_msec()
		if event.is_action_pressed("down") && can_move && can_move_bottom:
			NormalSpr.frame = 0
			StatueSpr.frame = 0
			Global.move_to(self, Global._grid_to_pixel(offset, 0, 1))
			last_move_time = Time.get_ticks_msec()

func _move_ghost(target_pos: Vector2):
	can_move = false
	object_position += target_pos
	var tween = create_tween()
	
	tween.tween_property(self, "position", object_position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(0.15).timeout
	can_move = true

func _grid_to_pixel(x: int, y: int) -> Vector2:
	return Vector2(offset * x, offset * y)

func check_move(move_dir : Vector2) -> bool:
	if move_dir.x > 0 and not can_move_right:
		return false
	if move_dir.x < 0 and not can_move_left:
		return false
	if move_dir.y < 0 and not can_move_top:
		return false
	if move_dir.y > 0 and not can_move_bottom:
		return false
	return true

func _on_left_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_left = false

func _on_left_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_left = true

func _on_top_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_top = false

func _on_top_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_top = true

func _on_bottom_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_bottom = false

func _on_bottom_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_bottom = true

func _on_right_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_right = false

func _on_right_collider_area_exited(area: Area2D) -> void:
	if area.is_in_group("Border") || area.is_in_group("Wall") || area.is_in_group("Breakables"):
		can_move_right = true
