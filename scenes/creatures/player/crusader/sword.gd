extends Node2D


var damage: int = 3


func _process(_delta: float) -> void:
	if get_parent().get_parent().is_dying:
		queue_free()
