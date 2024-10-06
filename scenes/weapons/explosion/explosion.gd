extends Node2D


var damage: int = 5


func _ready() -> void:
	AudioBus.play("Explosion")


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
