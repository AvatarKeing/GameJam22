extends Area2D

@onready var breakable_section: Area2D = $BreakableSection

func _on_breakable_section_area_entered(area: Area2D) -> void:
	if area.is_in_group("Arrow"):
		Audio.get_script().play_sfx(Global.sfx_type.BREAK)
		breakable_section.queue_free()
		area.get_parent().get_parent().reset_arrow()
