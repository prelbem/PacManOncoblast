extends Control

##Hides the pause menu and resumes the game.
func _on_continue_pressed() -> void:
	visible = false
	get_node("../../HUD/ScreenTint").visible = false
	get_tree().paused = false

##Exits the game.
func _on_quit_pressed() -> void:
	get_tree().quit()
	
##Goes back to the title screen.
func _on_menu_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.TITLE_SCREEN)
