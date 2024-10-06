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


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = (get_tree().current_scene.player_controller.position - position).normalized()
	velocity = direction * speed
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	move_and_slide()


func take_damage(amount: int) -> void:
	AudioBus.play("BulletHit")
	hp_current -= amount
	modulate = Color(100.0, 0.0, 0.0, 1.0)
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE


func die() -> void:
	get_tree().current_scene.call_deferred("spawn_experience", global_position)
	get_tree().current_scene.call_deferred("spawn_random_enemy_after_delay")
	if hp_max >= 100:
		get_tree().current_scene.call_deferred("win")
	queue_free()


func _on_spawn_invulnerability_timer_timeout() -> void:
	collision_with_enemies.disabled = false
	collision_with_player.disabled = false
