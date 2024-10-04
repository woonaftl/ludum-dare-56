extends Window


@onready var display_mode_button: OptionButton = %DisplayModeButton as OptionButton
@onready var display_option_container: HBoxContainer = %DisplayOptionContainer as HBoxContainer
@onready var language_button: OptionButton = %LanguageButton as OptionButton
@onready var back_button = %BackButton


func _ready() -> void:
	back_button.grab_focus()
	get_tree().paused = true
	display_option_container.visible = not OS.has_feature("web")
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			display_mode_button.select(1)
		_:
			display_mode_button.select(0)
	match TranslationServer.get_locale().substr(0, 2):
		"ru":
			language_button.select(2)
		"es":
			language_button.select(1)
		_:
			language_button.select(0)


func _process(_delta: float) -> void:
	move_to_center()


func _on_back_button_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_display_mode_button_item_selected(index: int) -> void:
	match index:
		0:
			UserSettings.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			UserSettings.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_language_button_item_selected(index: int) -> void:
	match index:
		0:
			UserSettings.set_locale("en")
		1:
			UserSettings.set_locale("es")
		2:
			UserSettings.set_locale("ru")
