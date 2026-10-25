extends Node2D

# State Machine
enum moveState {DEAD, FOCUS}
var currentState
var possessor

var can_rotate = true

# Grid Variables
@export_category("Grid Variables")
@export var object_position: Vector2 = Vector2(832, 320)

const rotate_speed : float = 1.0

var can_move = true
var can_move_left = true
var can_move_right = true
var can_move_top = true
var can_move_bottom = true

func _ready() -> void:
	object_position = position
	currentState = moveState.DEAD
	reset_arrow()
	
func _input(event: InputEvent) -> void:
	if currentState == moveState.FOCUS:
		if can_rotate:
			%Sprite.frame = 1
			if event.is_action_pressed("left"):
				can_rotate = false
				var rotTween = create_tween()
				rotTween.tween_property($Rotate, "rotation", $Rotate.rotation + -PI / 2, 0.125).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
				await get_tree().create_timer(0.125).timeout
				can_rotate = true
			if event.is_action_pressed("right"):
				can_rotate = false
				var rotTween = create_tween()
				rotTween.tween_property($Rotate, "rotation", $Rotate.rotation + PI / 2, 0.125).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
				await get_tree().create_timer(0.125).timeout
				can_rotate = true

func unposses() -> void:
	_shoot()

var shoot_tween : Tween

func _shoot() -> void:
	%Sprite.frame = 2
	if shoot_tween != null:
		shoot_tween.kill()
		
	%Arrow.visible = true
	%Arrow.process_mode = Node.PROCESS_MODE_INHERIT
	shoot_tween = create_tween()
	shoot_tween.tween_property(%Arrow, "position", Vector2(0.0, -3000.0), 2.0)
	shoot_tween.tween_callback(reset_arrow)
	
func reset_arrow() -> void:
	%Sprite.frame = 0
	if shoot_tween != null:
		shoot_tween.kill()
	%Arrow.visible = false
	%Arrow.position = Vector2.ZERO
	%Arrow.process_mode = Node.PROCESS_MODE_DISABLED

func _on_arrow_area_entered(_area: Area2D) -> void:
	# TODO: Call whatever function on the object
	
	if shoot_tween != null:
		shoot_tween.kill()
	reset_arrow()



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
