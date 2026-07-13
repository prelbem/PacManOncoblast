extends TextureRect

func _ready():
	get_tree().paused = false

func _on_play_button_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.MAIN_LEVEL)

func _on_settings_button_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.SETTINGS)
