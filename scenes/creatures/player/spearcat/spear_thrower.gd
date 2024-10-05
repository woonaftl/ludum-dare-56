extends Timer


func _on_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() > 0:
		var spear = ScenePaths.SPEAR.instantiate()
		spear.global_position = get_parent().global_position
		get_tree().current_scene.add_child(spear)
		var closest_enemy: Node2D = get_tree().get_nodes_in_group("enemy").reduce(
			func(accumulator, next):
				if (next.global_position - spear.global_position).length() < (accumulator.global_position - spear.global_position).length():
					return next
				else:
					return accumulator
		)
		spear.direction = (closest_enemy.global_position - spear.global_position).normalized()
