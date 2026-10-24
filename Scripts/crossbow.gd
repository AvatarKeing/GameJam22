extends Sprite2D

# State Machine
enum moveState {DEAD, FOCUS}
var currentState
var possessor

# Grid Variables
@export_category("Grid Variables")
@export var object_position: Vector2 = Vector2(832, 320)

const rotate_speed : float = 1.0

func _ready() -> void:
	currentState = moveState.DEAD
	reset_arrow()
	
func _process(delta: float) -> void:
	if currentState == moveState.FOCUS:
		frame = 1
		if Input.is_action_pressed("left"):
			rotate(-rotate_speed * delta)
		if Input.is_action_pressed("right"):
			rotate(rotate_speed * delta)

func unposses() -> void:
	_shoot()

var shoot_tween : Tween

func _shoot() -> void:
	frame = 2
	if shoot_tween != null:
		shoot_tween.kill()
		
	$Arrow.visible = true
	$Arrow.process_mode = Node.PROCESS_MODE_INHERIT
	shoot_tween = create_tween()
	shoot_tween.tween_property($Arrow, "position", Vector2(0.0, -3000.0), 2.0)
	shoot_tween.tween_callback(reset_arrow)
	
func reset_arrow() -> void:
	frame = 0
	if shoot_tween != null:
		shoot_tween.kill()
	$Arrow.visible = false
	$Arrow.position = Vector2.ZERO
	$Arrow.process_mode = Node.PROCESS_MODE_DISABLED

func _on_arrow_area_entered(_area: Area2D) -> void:
	# TODO: Call whatever function on the object
	
	if shoot_tween != null:
		shoot_tween.kill()
	reset_arrow()
