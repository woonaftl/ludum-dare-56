extends Button


func _on_pressed():
	AudioBus.play("Click")
	UserSettings.set_locale("en")
	get_tree().change_scene_to_file(ScenePaths.MAIN_MENU)
