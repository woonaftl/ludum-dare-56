extends Timer


var is_horizontal: bool = true


func _on_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() > 0:
		var grenade = ScenePaths.GRENADE.instantiate()
		get_tree().current_scene.add_child(grenade)
		grenade.global_position = get_parent().global_position
		var closest_enemy: Node2D = get_tree().get_nodes_in_group("enemy").reduce(
			func(accumulator, next):
				if (next.global_position - grenade.global_position).length() < (accumulator.global_position - grenade.global_position).length():
					return next
				else:
					return accumulator
		)
		grenade.direction = (closest_enemy.global_position - grenade.global_position).normalized()
