extends Area2D

enum ghostState {FOCUS, POSSESS}
var currentState



func _ready() -> void:
	currentState = ghostState.FOCUS

func _input(event: InputEvent) -> void:
	if currentState == ghostState.FOCUS:
		pass

func _grid_to_pixel(x: int, y: int) -> void:
	pass
