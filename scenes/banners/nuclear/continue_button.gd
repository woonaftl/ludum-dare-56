extends Button


func _ready() -> void:
	grab_focus()


func _on_pressed() -> void:
	AudioBus.play("Click")
	get_tree().change_scene_to_file(ScenePaths.BANNER_GRASSLAND)
