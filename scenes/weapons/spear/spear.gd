extends Node2D


var speed: float = 250.0
var damage: int = 1
var direction: Vector2


func _physics_process(delta: float) -> void:
	rotation = Vector2.LEFT.angle_to(direction)
	if direction:
		position += direction * speed * delta
	else:
		queue_free()


func _on_lifespan_timer_timeout() -> void:
	queue_free()
