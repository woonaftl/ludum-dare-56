extends Area2D


func _on_body_exited(body: Node2D) -> void:
	body.queue_free()
	get_tree().current_scene.call_deferred("spawn_enemy")
