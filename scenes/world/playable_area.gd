extends Area2D


func _on_body_exited(body: Node2D) -> void:
	var center: Vector2 = get_tree().current_scene.player_controller.global_position
	body.global_position = center + 500.0 * Vector2.LEFT.rotated(randf_range(0, PI * 2))
