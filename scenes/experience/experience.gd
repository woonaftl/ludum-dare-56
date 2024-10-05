extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.add_experience()
	queue_free()


func _on_lifespan_timer_timeout() -> void:
	queue_free()


func _on_warning_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 0.0, 0.0, 0.5), 2).set_trans(Tween.TRANS_SINE)
