extends Timer


func _on_timeout() -> void:
	if not get_parent().is_dying:
		get_parent().animated_sprite.play("shoot")
		await get_tree().create_timer(0.4).timeout
		AudioBus.play("Ritual")
		var ritual_explosion = ScenePaths.RITUAL_EXPLOSION.instantiate()
		ritual_explosion.global_position = get_parent().global_position
		get_tree().current_scene.add_child(ritual_explosion)
