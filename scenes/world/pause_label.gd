extends Label


func _process(_delta: float) -> void:
	visible = get_tree().paused
	if not get_tree().current_scene.is_victory and \
		not get_tree().current_scene.game_over_container.visible and \
		not get_tree().current_scene.reward_panel_container.visible and \
		not get_tree().current_scene.pause_menu_container.visible and \
		Input.get_vector("move_left", "move_right", "move_up", "move_down"):
			get_tree().paused = false
