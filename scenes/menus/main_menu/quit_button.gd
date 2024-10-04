extends Button


func _ready() -> void:
	if OS.has_feature("web"):
		visible = false
		focus_mode = Control.FOCUS_NONE
	else:
		visible = true
		focus_mode = Control.FOCUS_ALL


func _on_pressed():
	get_tree().quit()
