extends Control

func _ready():
	Audio.get_script()._mainmenu()
	pass

func _on_play_pressed():
	Audio.get_script().play_sfx(Global.sfx_type.MENU_BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")

func _on_options_pressed():
	Audio.get_script().play_sfx(Global.sfx_type.MENU_BUTTON)
	get_tree().change_scene_to_file("res://Scenes/Directions.tscn")
	
func _on_quit_pressed():
	Audio.get_script().play_sfx(Global.sfx_type.MENU_BUTTON)
	get_tree().quit()
