extends Node2D
class_name PlayerController


const SPEED = 150.0


func _physics_process(delta: float) -> void:
	if get_parent().player_level > 0:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if direction:
			position += direction * delta * SPEED
