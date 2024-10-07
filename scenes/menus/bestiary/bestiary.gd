extends Control


@onready var h_flow_container: HFlowContainer = %HFlowContainer
@onready var main_menu_button: Button = %MainMenuButton


func _ready() -> void:
	main_menu_button.grab_focus()
	for creature in Creatures.unlocks:
		var entry = preload(ScenePaths.BESTIARY_ENTRY).instantiate()
		h_flow_container.add_child(entry)
		entry.creature = creature
