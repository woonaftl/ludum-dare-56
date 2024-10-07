extends CharacterBody2D


var speed: float = 35.0
var damage: int = 1


@export var hp_max: int


@onready var hp_current: int = hp_max:
	set(new_value):
		hp_current = clampi(new_value, 0, hp_max)
		if hp_current == 0:
			die()


@onready var collision_with_enemies: CollisionShape2D = %CollisionWithEnemies
@onready var collision_with_player: CollisionShape2D = %CollisionWithPlayer
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var damage_area: Area2D = %DamageArea


func _physics_process(_delta: float) -> void:
	if hp_current > 0:
		var direction: Vector2 = (get_tree().current_scene.player_controller.position - position).normalized()
		velocity = direction * speed
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true
		move_and_slide()


func take_damage(amount: int) -> void:
	if hp_current > 0 and not collision_with_player.disabled:
		AudioBus.play("BulletHit")
		hp_current -= amount
		modulate = Color(100.0, 0.0, 0.0, 1.0)
		await get_tree().create_timer(0.05).timeout
		modulate = Color.WHITE
		if hp_current < 90:
			if has_node("Label"):
				$Label.queue_free()


func die() -> void:
	damage_area.queue_free()
	get_tree().current_scene.enemies_killed += 1
	animated_sprite.play("die")
	if hp_max >= 100:
		process_mode = PROCESS_MODE_ALWAYS
		get_tree().current_scene.camera_2d.focus_on(global_position)
		get_tree().current_scene.call_deferred("win")


func _on_spawn_invulnerability_timer_timeout() -> void:
	collision_with_enemies.disabled = false
	collision_with_player.disabled = false


func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "die":
		if hp_max < 100:
			get_tree().current_scene.call_deferred("spawn_experience", global_position)
			get_tree().current_scene.call_deferred("spawn_random_enemy_after_delay")
		queue_free()
