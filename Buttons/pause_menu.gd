extends Control

func _ready():
	pass

func _on_continue_pressed() -> void:
	visible = false
	get_node("../../HUD/ScreenTint").visible = false
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_menu_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.TITLE_SCREEN)
