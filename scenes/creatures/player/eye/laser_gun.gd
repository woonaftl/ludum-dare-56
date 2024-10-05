extends Timer


var is_horizontal: bool = true


func _on_timeout() -> void:
	get_parent().animated_sprite.play("shoot")
	await get_tree().create_timer(0.2).timeout
	if is_horizontal:
		var laser = ScenePaths.LASER_HORIZONTAL.instantiate()
		get_parent().add_child(laser)
		is_horizontal = false
	else:
		var laser = ScenePaths.LASER_VERTICAL.instantiate()
		get_parent().add_child(laser)
		is_horizontal = true
