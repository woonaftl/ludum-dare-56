extends Button


func _on_pressed():
	UserSettings.set_locale("es")
	get_tree().change_scene_to_file(ScenePaths.MAIN_MENU)
