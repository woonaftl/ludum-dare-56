extends CharacterBody2D


var is_dying = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite


func _physics_process(_delta: float) -> void:
	if not is_dying:
		var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_vector:
			velocity = -position + get_movement_randomizer()
		else:
			velocity = -position
		if input_vector.x > 0:
			animated_sprite.flip_h = false
		elif input_vector.x < 0:
			animated_sprite.flip_h = true
		move_and_slide()


func take_damage(_amount: int) -> void:
	AudioBus.play("CreatureDie")
	is_dying = true
	call_deferred("reparent", get_tree().current_scene)
	animated_sprite.play("die")


func get_movement_randomizer() -> Vector2:
	var creature_count: int = get_tree().current_scene.player_level
	if creature_count > 1:
		return Vector2(randf_range(-32., 32.), randf_range(-32., 32.))
	else:
		return Vector2.ZERO


func add_experience() -> void:
	get_tree().current_scene.call_deferred("add_experience")


func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "shoot":
		animated_sprite.play("default")
	if animated_sprite.animation == "die":
		queue_free()
