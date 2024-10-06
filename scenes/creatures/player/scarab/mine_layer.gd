extends Timer


func _on_timeout() -> void:
	if not get_parent().is_dying:
		get_parent().animated_sprite.play("shoot")
		await get_parent().animated_sprite.animation_finished
		AudioBus.play("MineLay")
		var mine = ScenePaths.MINE.instantiate()
		get_tree().current_scene.add_child(mine)
		mine.global_position = get_parent().global_position
