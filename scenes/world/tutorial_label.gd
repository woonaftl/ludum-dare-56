extends RichTextLabel


func _ready() -> void:
	if UserSettings.skip_tutorial:
		queue_free()


func _on_tutorial_lifespan_timer_timeout() -> void:
	queue_free()
