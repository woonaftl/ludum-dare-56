extends Timer


var is_horizontal: bool = true


func _on_timeout() -> void:
	if not get_parent().is_dying:
		get_parent().animated_sprite.play("shoot")
		await get_tree().create_timer(0.2).timeout
		AudioBus.play("LaserShoot")
		if is_horizontal:
			var laser = ScenePaths.LASER_HORIZONTAL.instantiate()
			get_parent().add_child(laser)
			is_horizontal = false
		else:
			var laser = ScenePaths.LASER_VERTICAL.instantiate()
			get_parent().add_child(laser)
			is_horizontal = true
