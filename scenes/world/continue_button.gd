extends Button


@onready var pause_menu_container: CenterContainer = %PauseMenuContainer


func _on_pressed() -> void:
	AudioBus.play("Click")
	pause_menu_container.visible = false
	get_tree().paused = false
