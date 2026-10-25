extends Node

var audio_sources = Array([], TYPE_OBJECT, "Node", null)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_sources = get_children()
	
	for n in range(0,3):
		print(audio_sources[n].value)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _playall() -> void:
	pass

func _play(desired_audio : int) -> void:
	if desired_audio < 4 && desired_audio >= 0:
		pass
	else:
		audio_sources[desired_audio].playing = true
		pass
		
