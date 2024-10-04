extends Control


@onready var english_button = %EnglishButton


func _ready():
	english_button.grab_focus()
