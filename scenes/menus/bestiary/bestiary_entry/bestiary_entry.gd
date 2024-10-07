extends PanelContainer


@onready var title_label: RichTextLabel = %TitleLabel
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var description_label: RichTextLabel = %DescriptionLabel
@onready var creature: PackedScene:
	set(new_value):
		creature = new_value
		title_label.text = tr(Creatures.NAME_BY_CREATURE[creature] + "_TITLE")
		description_label.text = tr(Creatures.NAME_BY_CREATURE[creature] + "_DESCRIPTION")
		animated_sprite.sprite_frames = Creatures.SPRITE_BY_CREATURE[creature]
		animated_sprite.play("default")
		if creature == ScenePaths.BOSS:
			animated_sprite.scale = Vector2(3, 3)
