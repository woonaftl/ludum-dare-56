extends Button


func _on_pressed():
	AudioBus.play("Click")
	get_tree().change_scene_to_file(ScenePaths.CREDITS)
