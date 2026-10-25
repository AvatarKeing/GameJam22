extends Area2D

var active = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pushables"):
		active = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Pushables"):
		active = false
