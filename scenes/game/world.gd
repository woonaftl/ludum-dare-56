extends Node2D


const STARTING_ENEMY_COUNT = 12


var all_creatures = [
	ScenePaths.EYE,
	ScenePaths.GUNNER,
	ScenePaths.KNIGHT,
	ScenePaths.PYRO,
	ScenePaths.SPEARCAT,
	ScenePaths.TRAPPER,
	ScenePaths.WITCH,
]
var name_by_creature = {
	ScenePaths.EYE: "EYE",
	ScenePaths.GUNNER: "GUNNER",
	ScenePaths.KNIGHT: "KNIGHT",
	ScenePaths.PYRO: "PYRO",
	ScenePaths.SPEARCAT: "SPEARCAT",
	ScenePaths.TRAPPER: "TRAPPER",
	ScenePaths.WITCH: "WITCH",
}
var texture_by_creature = {
	ScenePaths.EYE: preload("uid://bhiwt71vycmfg").get_frame_texture("default", 0),
	ScenePaths.GUNNER: preload("res://2d/creatures/player/gunner.png"),
	ScenePaths.KNIGHT: preload("res://2d/creatures/player/knight.png"),
	ScenePaths.PYRO: preload("res://2d/creatures/player/pyro.png"),
	ScenePaths.SPEARCAT: preload("res://2d/creatures/player/spearcat.png"),
	ScenePaths.TRAPPER: preload("res://2d/creatures/player/trapper.png"),
	ScenePaths.WITCH: preload("res://2d/creatures/player/witch.png"),
}


var is_active: bool = true
var player_level: int = 1


@onready var player_controller: PlayerController = %PlayerController as PlayerController
@onready var enemies: Node2D = %Enemies
@onready var creatures: Node2D = %Creatures
@onready var game_over_dialog: AcceptDialog = $GameOverDialog
@onready var experience_bar: ExperienceBar = %ExperienceBar as ExperienceBar
@onready var reward_container: HBoxContainer = %RewardContainer
@onready var reward_panel_container: CenterContainer = %RewardPanelContainer


@onready var experience_needed: float = 4.0:
	set(new_value):
		experience_needed = new_value
		experience_bar.update(experience, experience_needed)


@onready var experience: float = 0.0:
	set(new_value):
		experience = new_value
		if experience >= experience_needed:
			experience -= experience_needed
			level_up()
		experience_bar.update(experience, experience_needed)


func _ready() -> void:
	randomize()
	for i in range(STARTING_ENEMY_COUNT):
		spawn_enemy()
	all_creatures.shuffle()
	add_creature(all_creatures[0])


func spawn_enemy_after_delay() -> void:
	await get_tree().create_timer(randf_range(2.0, 8.0)).timeout
	spawn_enemy()


func spawn_enemy() -> void:
	if is_active:
		if get_tree().get_nodes_in_group("enemy").size() < get_enemy_count_limit():
			var lice = ScenePaths.LICE.instantiate()
			lice.global_position = player_controller.global_position + 500.0 * Vector2.LEFT.rotated(randf_range(0, PI * 2))
			enemies.add_child(lice)


func get_enemy_count_limit() -> int:
	return clampi(80 + player_level * 5, 80, 150)


func _process(_delta: float) -> void:
	player_level = get_tree().get_nodes_in_group("player").size()
	if player_level == 0:
		game_over()
	else:
		recalc_xp()


func game_over() -> void:
	is_active = false
	game_over_dialog.popup_centered()


func _on_game_over_dialog_confirmed() -> void:
	get_tree().change_scene_to_file(ScenePaths.MAIN_MENU)


func _on_game_over_dialog_canceled() -> void:
	get_tree().change_scene_to_file(ScenePaths.MAIN_MENU)


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
	get_tree().paused = true
	reward_panel_container.visible = true
	all_creatures.shuffle()
	for i in range(3):
		var reward = preload(ScenePaths.REWARD).instantiate()
		reward_container.add_child(reward)
		var creature = all_creatures[i]
		reward.creature = creature
		reward.title_label.text = tr(name_by_creature[creature] + "_TITLE")
		reward.description_label.text = tr(name_by_creature[creature] + "_DESCRIPTION")
		reward.texture_rect.texture = texture_by_creature[creature]


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
	spawn_enemy()
