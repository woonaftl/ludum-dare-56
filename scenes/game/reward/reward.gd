extends VBoxContainer


var creature
@onready var title_label: RichTextLabel = %TitleLabel
@onready var description_label: RichTextLabel = %DescriptionLabel
@onready var texture_rect: TextureRect = %TextureRect as TextureRect


func _on_button_pressed() -> void:
	get_tree().current_scene.add_creature(creature)
