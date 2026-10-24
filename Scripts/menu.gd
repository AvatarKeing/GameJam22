extends Control

func _ready():
	pass
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/Options Scene.tscn")
	
func _on_quit_pressed():
	get_tree().quit()


func _on_tutorials_pressed():
	get_tree().change_scene_to_file("res://scenes/directions.tscn")
