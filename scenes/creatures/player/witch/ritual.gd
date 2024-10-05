extends Timer


func _on_timeout() -> void:
	var ritual_explosion = ScenePaths.RITUAL_EXPLOSION.instantiate()
	ritual_explosion.global_position = get_parent().global_position
	get_tree().current_scene.add_child(ritual_explosion)
