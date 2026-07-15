extends Control

func _ready():
	get_tree().paused = false

func _on_play_button_pressed() -> void:
	$AnimationPlayer.play("to_level")

func _on_settings_button_pressed() -> void:
	$AnimationPlayer.play("to_settings")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"to_settings":
			GameManager.change_scene(GameManager.Scenes.SETTINGS)
		"to_level":
			GameManager.change_scene(GameManager.Scenes.MAIN_LEVEL)
