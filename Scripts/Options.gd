extends Control

func _on_quit_pressed():
	get_tree().quit()


func _on_directions_pressed():
	get_tree().change_scene_to_file("res://scenes/directions.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
