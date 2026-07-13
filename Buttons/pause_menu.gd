extends Control

func _ready():
	pass

func _on_continue_pressed() -> void:
	var player = get_node("../../PlayerManager")
	var damage_timer: Timer = player.get_node("Pause")
	damage_timer.paused = false;
	visible = false
	get_node("../../HUD/ScreenTint").visible = false
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_menu_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.MAIN_LEVEL)
