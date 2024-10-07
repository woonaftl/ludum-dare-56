extends Node2D


var speed: float = 400.0
var is_vacuumed = false


func _process(delta: float) -> void:
	if is_vacuumed:
		global_position = global_position.move_toward(get_tree().current_scene.player_controller.global_position, speed * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	AudioBus.play("PickupXp")
	body.add_experience()
	queue_free()


func _on_lifespan_timer_timeout() -> void:
	queue_free()


func _on_warning_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 0.0, 0.0, 0.5), 2).set_trans(Tween.TRANS_SINE)
