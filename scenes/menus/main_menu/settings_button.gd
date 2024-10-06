extends Button


func _on_pressed():
	AudioBus.play("Click")
	var settings: Window = preload(ScenePaths.SETTINGS).instantiate() as Window
	add_child(settings)
	settings.popup_centered()
