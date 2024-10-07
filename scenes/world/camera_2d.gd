extends Camera2D


func focus_on(global_pos: Vector2) -> void:
	reparent(get_tree().current_scene)
	global_position = global_pos
	zoom = Vector2(2, 2)
