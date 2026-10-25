extends Node2D

static var sfx_clips: Array[AudioStreamMP3]
static var is_playing: Array[bool] = [false,false,false,false]
static var correct_volume: Array[bool] = [false,false,false,false]
var actual_nodes: Array[AudioStreamPlayer2D]
static var sfx_node

func _ready() -> void:
	actual_nodes = [$"001",$"002",$"003",$"004"]
	sfx_node = $"SFX"
	# enum sfx_type {BELLOWS, CROSSBOW, MENU_BUTTON, POSSESSION, ROCK_MOVING, SWORD, BREAK}
	
	#this stinks. sorey
	sfx_clips = [ResourceLoader.load("res://Audio/SFX/Bellows final.mp3"),ResourceLoader.load("res://Audio/SFX/Crossbow.mp3"),ResourceLoader.load("res://Audio/SFX/Menu Button.mp3"),ResourceLoader.load("res://Audio/SFX/Possession.mp3"),ResourceLoader.load("res://Audio/SFX/Rock Moving.mp3"),ResourceLoader.load("res://Audio/SFX/Sword.mp3"),ResourceLoader.load("res://Audio/SFX/Wood crate breaking.mp3")]
	set_process(true)
	for n in 4:
		actual_nodes[n].play()
	
	_force_music()

func _force_music() -> void:
	# fix to for loop
	for n in 4:
		if (is_playing[n]):
			actual_nodes[n].volume_db = 0
		else:
			actual_nodes[n].volume_db = -100
	correct_volume = [true,true,true,true]

static func _mainmenu() -> void:
	is_playing = [false,true,true,false]
	correct_volume = [false,false,false,false]

static func _maingamestatue() -> void:
	is_playing = [true,true,true,false]
	correct_volume = [false,false,false,false]

static func _maingameghost() -> void:
	is_playing = [true,true,true,true]
	correct_volume = [false,false,false,false]

static func play_sfx(track: Global.sfx_type) -> void:
	sfx_node.stop()
	sfx_node.stream = sfx_clips[track]
	sfx_node.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##_force_music()
	for n in 4:
		if (!correct_volume[n]):
			_force_correct_volume(n, delta)

func _check_correct_volume(position: int) -> bool:
	if (!is_playing[position] && actual_nodes[position].volume_db < -50):
		actual_nodes[position].volume_db = -100
		return true
	if (is_playing[position] && actual_nodes[position].volume_db > 1):
		actual_nodes[position].volume_db = 1
		return true
	return false

func _force_correct_volume(position: int, delta: float) -> void:
	for n in 4:
		if (!correct_volume[n]):
			if (is_playing[n]):
				actual_nodes[n].volume_db = actual_nodes[n].volume_db + (delta*100)
			else:
				actual_nodes[n].volume_db = actual_nodes[n].volume_db - (delta*10)
			correct_volume[n] = _check_correct_volume(n)
