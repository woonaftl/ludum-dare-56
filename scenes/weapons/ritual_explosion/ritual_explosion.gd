extends Node2D


var damage: int = 5


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.5), 1).set_trans(Tween.TRANS_SINE)


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
