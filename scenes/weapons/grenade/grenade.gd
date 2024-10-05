extends Node2D


var speed: float = 250.0
var direction: Vector2


func _physics_process(delta: float) -> void:
	if direction:
		speed = clampf(speed * 0.95, 0.0, speed)
		position += direction * speed * delta
	else:
		queue_free()


func _on_lifespan_timer_timeout() -> void:
	get_tree().current_scene.call_deferred("spawn_explosion", global_position)
	queue_free()
