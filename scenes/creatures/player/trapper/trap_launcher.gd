extends Timer


func _on_timeout() -> void:
	var trap = ScenePaths.TRAP.instantiate()
	get_tree().current_scene.add_child(trap)
	trap.global_position = get_parent().global_position
