extends Timer


func _on_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() > 0 and not get_parent().is_dying:
		AudioBus.play("GunShoot")
		get_parent().animated_sprite.play("shoot")
		var bullet = ScenePaths.BULLET.instantiate()
		bullet.global_position = get_parent().global_position
		get_tree().current_scene.add_child(bullet)
		var closest_enemy: Node2D = get_tree().get_nodes_in_group("enemy").reduce(
			func(accumulator, next):
				if (next.global_position - bullet.global_position).length() < (accumulator.global_position - bullet.global_position).length():
					return next
				else:
					return accumulator
		)
		bullet.direction = (closest_enemy.global_position - bullet.global_position).normalized()
