extends Node


func _ready() -> void:
	var viewport_size: Vector2 = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	var current_window = get_window()
	current_window.min_size = viewport_size
	current_window.size = 2 * viewport_size
	current_window.move_to_center()
