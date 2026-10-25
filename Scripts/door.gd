extends Area2D

@onready var tile_map: TileMap = $TileMap
@export var win_screen: Node
@export var button_parent: Node
@export var buttons_to_activate: int
var buttons_active = 0

func _process(delta: float) -> void:
	if button_parent != null:
		for i in button_parent.get_children():
			if i.active:
				buttons_active = 1
				if buttons_active >= buttons_to_activate:
					break
			else:
				buttons_active = 0
		if buttons_active >= buttons_to_activate:
			tile_map.visible = false
		else:
			tile_map.visible = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Possessables"):
		if button_parent != null:
			for i in button_parent.get_children():
				if i.active:
					buttons_active += 1
					if buttons_active >= buttons_to_activate:
						break
			if buttons_active >= buttons_to_activate:
				win_screen.visible = true
				tile_map.visible = false
				area.get_parent().visible = false
				area.get_parent().currentState = area.get_parent().moveState.DEAD
		else:
			win_screen.visible = true
			tile_map.visible = false
			area.get_parent().visible = false
			area.get_parent().currentState = area.get_parent().moveState.DEAD
