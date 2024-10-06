extends Label


func _process(_delta: float) -> void:
	visible = UserSettings.show_timer
	text = UserSettings.format_time(get_tree().current_scene.get_time_since_start())
