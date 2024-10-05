extends Node2D


var speed: float = 400.0
var damage: int = 1
var direction: Vector2


func _physics_process(delta: float) -> void:
	if direction:
		position += direction * speed * delta
	else:
		queue_free()


func _on_damage_area_body_entered(_body: Node2D) -> void:
	queue_free()


func _on_lifespan_timer_timeout() -> void:
	queue_free()
