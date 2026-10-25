extends Control


func _on_button_pressed() -> void:
	Audio.get_script().play_sfx(Global.sfx_type.MENU_BUTTON)
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
