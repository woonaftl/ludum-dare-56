extends Node2D


func _on_lifespan_timer_timeout() -> void:
	get_tree().current_scene.call_deferred("spawn_explosion", global_position)
	queue_free()


func _on_trigger_area_body_entered(_body: Node2D) -> void:
	get_tree().current_scene.call_deferred("spawn_explosion", global_position)
	queue_free()
