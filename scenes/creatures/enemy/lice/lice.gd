extends CharacterBody2D


var speed: float = 35.0
var damage: int = 1


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


func take_damage(_amount: int) -> void:
	get_tree().current_scene.call_deferred("spawn_experience", global_position)
	get_tree().current_scene.call_deferred("spawn_enemy_after_delay")
	queue_free()


func _on_spawn_invulnerability_timer_timeout() -> void:
	collision_with_enemies.disabled = false
	collision_with_player.disabled = false
