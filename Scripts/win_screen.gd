extends Control

@export var current_scene: int

func _on_button_pressed() -> void:
	Audio.get_script().play_sfx(Global.sfx_type.MENU_BUTTON)
	match current_scene:
		1:
			get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Level3.tscn")
		3:
			get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
