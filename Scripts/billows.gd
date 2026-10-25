extends Node2D

# State Machine
enum moveState {DEAD, FOCUS}
var currentState
var possessor

# Grid Variables
@export_category("Grid Variables")
@export var object_position: Vector2 = Vector2(832, 320)

@export_category("Specific changes")
@export var dir : Vector2 = Vector2(0, -1)

const rotate_speed : float = 1.0

func _ready() -> void:
	$RayCast2D.enabled = false
	$RayCast2D.target_position = dir * 2000
	currentState = moveState.DEAD
	
func _process(_delta: float) -> void:
	object_position = position

var anim_tween : Tween

func unposses() -> void:
	$RayCast2D.enabled = true
	$RayCast2D.force_raycast_update()
	$RayCast2D.enabled = false
	
	
	if anim_tween != null:
		anim_tween.kill()
	anim_tween = create_tween()
	anim_tween.tween_property($Sprite2D, "frame", 1, 0.0)
	anim_tween.tween_interval(0.25)
	anim_tween.tween_property($Sprite2D, "frame", 0, 0.0)
	
	var col_obj : Object = $RayCast2D.get_collider()
	if col_obj == null: return
	if col_obj is Area2D and (col_obj as Node).is_in_group("Pushables"):
		Global.move_to(col_obj, dir * 128)
	
	
	
