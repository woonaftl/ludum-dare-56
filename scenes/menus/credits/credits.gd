extends Control


@onready var main_menu_button = %MainMenuButton


func _ready():
	main_menu_button.grab_focus()
