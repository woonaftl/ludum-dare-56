extends MarginContainer


var creature
@onready var title_label: RichTextLabel = %TitleLabel
@onready var description_label: RichTextLabel = %DescriptionLabel
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var button: Button = %Button


func _on_button_pressed() -> void:
	get_tree().current_scene.add_creature(creature)
