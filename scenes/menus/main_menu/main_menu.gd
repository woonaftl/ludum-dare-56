extends Control


@onready var play_button = %PlayButton


func _ready():
	play_button.grab_focus()
