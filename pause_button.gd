extends Button

func _on_pressed() -> void:
	get_tree().paused = true
	get_node("../../HUD/PauseMenu").visible = true
	get_node("../../HUD/ScreenTint").visible = true
