extends Node2D


var damage: int = 1


func _on_lifespan_timer_timeout() -> void:
	queue_free()
