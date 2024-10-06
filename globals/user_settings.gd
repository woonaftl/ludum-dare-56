extends Node


var skip_tutorial: bool = false
var show_timer: bool = true


func _ready() -> void:
	set_master_volume(-10)


func set_locale(new_value: String) -> void:
	TranslationServer.set_locale(new_value)


func set_master_volume(new_value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), new_value)


func window_set_mode(new_value: DisplayServer.WindowMode) -> void:
	DisplayServer.window_set_mode(new_value)


func format_time(s: float) -> String:
	@warning_ignore("integer_division")
	var minutes: int = int(s) / 60
	var seconds: int = int(s) % 60
	var deciseconds: int = int(s * 1000) % 1000
	return "%s:%02d.%03d" % [minutes, seconds, deciseconds]
