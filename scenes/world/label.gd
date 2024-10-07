extends RichTextLabel


func _process(_delta: float) -> void:
	text = "[center]" + tr("ENEMIES_KILLED") + " " + str(get_tree().current_scene.enemies_killed) + \
		"\n" + tr("TIME_SURVIVED") + " " + \
		UserSettings.format_time(get_tree().current_scene.get_time_since_start()) + "[/center]"
