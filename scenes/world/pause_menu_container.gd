extends CenterContainer


@onready var continue_button: Button = %ContinueButton


func _input(event: InputEvent) -> void:
	if not get_tree().current_scene.is_victory and \
		not get_tree().current_scene.game_over_container.visible and \
		not get_tree().current_scene.reward_panel_container.visible and \
		not get_tree().current_scene.pause_menu_container.visible and \
		event.is_action_pressed("ui_cancel"):
			get_tree().paused = true
			visible = true
			continue_button.grab_focus()
