extends Node2D


const STARTING_ENEMY_COUNT = 12


var all_creatures = [
	ScenePaths.CRUSADER,
	ScenePaths.LASIK,
	ScenePaths.PYRO,
	ScenePaths.SCARAB,
	ScenePaths.SHERIFF,
	ScenePaths.SPEARCAT,
	ScenePaths.WITCH,
]


var player_level: int = 1


@onready var player_controller: PlayerController = %PlayerController as PlayerController
@onready var enemies: Node2D = %Enemies
@onready var creatures: Node2D = %Creatures
@onready var game_over_dialog: AcceptDialog = $GameOverDialog
@onready var win_dialog: AcceptDialog = $WinDialog
@onready var experience_bar: ExperienceBar = %ExperienceBar as ExperienceBar
@onready var reward_container: HBoxContainer = %RewardContainer
@onready var reward_panel_container: CenterContainer = %RewardPanelContainer
@onready var timer_since_start: Timer = %TimerSinceStart as Timer
@onready var pause_menu_container: CenterContainer = %PauseMenuContainer
@onready var continue_button: Button = %ContinueButton


@onready var experience_needed: float = 4.0:
	set(new_value):
		experience_needed = new_value


@onready var experience: float = 0.0:
	set(new_value):
		experience = new_value
		if experience >= experience_needed:
			experience -= experience_needed
			level_up()


func _ready() -> void:
	randomize()
	get_tree().paused = false
	for i in range(STARTING_ENEMY_COUNT):
		spawn_random_enemy()
	all_creatures.shuffle()
	add_creature(ScenePaths.SHERIFF)


func _process(_delta: float) -> void:
	player_level = get_tree().get_nodes_in_group("player").filter(
		func(creature):
			return not creature.is_dying
	).size()
	if player_level == 0:
		game_over()
	else:
		recalc_xp()
		experience_bar.update(experience, experience_needed)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		pause_menu_container.visible = true
		continue_button.grab_focus()


func spawn_random_enemy_after_delay() -> void:
	await get_tree().create_timer(randf_range(2.0, 8.0)).timeout
	spawn_random_enemy()


func spawn_random_enemy() -> void:
	if is_inside_tree():
		if get_tree().get_nodes_in_group("enemy").size() < get_enemy_count_limit():
			var time: float = get_time_since_start()
			if time > 300.0:
				spawn_enemy(ScenePaths.ROACH)
			elif time > 240.0:
				var r = randf()
				if r > 0.4:
					spawn_enemy(ScenePaths.SPIDER)
				else:
					spawn_enemy(ScenePaths.ROACH)
			elif time > 180.0:
				var r = randf()
				if r > 0.8:
					spawn_enemy(ScenePaths.LICE)
				if r > 0.2:
					spawn_enemy(ScenePaths.SPIDER)
				else:
					spawn_enemy(ScenePaths.ROACH)
			elif time > 120.0:
				var r = randf()
				if r > 0.8:
					spawn_enemy(ScenePaths.LICE)
				else:
					spawn_enemy(ScenePaths.SPIDER)
			elif time > 60.0:
				var r = randf()
				if r > 0.4:
					spawn_enemy(ScenePaths.LICE)
				else:
					spawn_enemy(ScenePaths.SPIDER)
			else:
				spawn_enemy(ScenePaths.LICE)


func spawn_enemy(scene: PackedScene) -> void:
	var enemy = scene.instantiate()
	enemy.global_position = player_controller.global_position + 500.0 * Vector2.LEFT.rotated(randf_range(0, PI * 2))
	enemies.add_child(enemy)


func _on_boss_timer_timeout() -> void:
	spawn_enemy(ScenePaths.BOSS)


func get_enemy_count_limit() -> int:
	return clampi(80 + player_level * 5, 80, 150)


func game_over() -> void:
	game_over_dialog.popup_centered()


func _on_game_over_dialog_confirmed() -> void:
	get_tree().change_scene_to_file(ScenePaths.MAIN_MENU)


func _on_game_over_dialog_canceled() -> void:
	get_tree().change_scene_to_file(ScenePaths.MAIN_MENU)


func win() -> void:
	win_dialog.popup_centered()
	get_tree().paused = true


func _on_win_dialog_canceled() -> void:
	get_tree().change_scene_to_file(ScenePaths.CREDITS)


func _on_win_dialog_confirmed() -> void:
	get_tree().change_scene_to_file(ScenePaths.CREDITS)


func spawn_explosion(global_pos: Vector2) -> void:
	var explosion = ScenePaths.EXPLOSION.instantiate()
	explosion.global_position = global_pos
	add_child(explosion)


func spawn_experience(global_pos: Vector2) -> void:
	var experience_star = ScenePaths.EXPERIENCE.instantiate()
	experience_star.global_position = global_pos
	add_child(experience_star)


func add_experience() -> void:
	experience += 1.0


func level_up() -> void:
	AudioBus.play("LevelUp")
	get_tree().paused = true
	reward_panel_container.visible = true
	all_creatures.shuffle()
	for i in range(3):
		var reward = preload(ScenePaths.REWARD).instantiate()
		reward_container.add_child(reward)
		if i == 0:
			reward.button.grab_focus()
		var creature = all_creatures[i]
		reward.creature = creature
		reward.title_label.text = tr(Creatures.NAME_BY_CREATURE[creature] + "_TITLE")
		reward.description_label.text = tr(Creatures.NAME_BY_CREATURE[creature] + "_DESCRIPTION")
		reward.animated_sprite.sprite_frames = Creatures.SPRITE_BY_CREATURE[creature]
		reward.animated_sprite.play("default")


func add_creature(creature: PackedScene) -> void:
	get_tree().paused = false
	for reward in reward_container.get_children():
		reward.queue_free()
	reward_panel_container.visible = false
	var new_creature = creature.instantiate()
	creatures.add_child(new_creature)
	if player_level == 1:
		get_tree().get_first_node_in_group("player").position = Vector2(-5, 0)
		new_creature.position = Vector2(5, 0)


func recalc_xp() -> void:
	var new_experience_needed = 3 + pow(player_level, 2)
	if new_experience_needed < experience_needed:
		experience = experience * new_experience_needed / experience_needed
	experience_needed = new_experience_needed


func _on_increase_enemy_number_timer_timeout() -> void:
	spawn_random_enemy()


func get_time_since_start() -> float:
	return timer_since_start.wait_time - timer_since_start.time_left
