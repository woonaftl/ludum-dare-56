extends Node2D


const ROTATION_SPEED = 2.0


func _physics_process(delta: float) -> void:
	rotation += ROTATION_SPEED * delta
