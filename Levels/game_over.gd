extends ColorRect

func _on_button_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.MAIN_LEVEL)
