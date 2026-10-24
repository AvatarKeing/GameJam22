extends Node

var audio_sources = Array([], TYPE_OBJECT, "Node", null)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_sources = get_children()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _playall() -> void:
	pass

func _play(_int) -> void:
	if _int > 4:
		audio_sources[0]
		pass
	else:
		
