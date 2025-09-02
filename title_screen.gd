extends Node2D


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_level.tscn")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")
