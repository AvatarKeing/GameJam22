extends Area2D

@onready var tile_map: TileMap = $TileMap
@export var win_screen: Node

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Possessables"):
		win_screen.visible = true
		tile_map.clear()
		area.get_parent().visible = false
		area.get_parent().currentState = area.get_parent().moveState.DEAD
		#run some end cutscene script
