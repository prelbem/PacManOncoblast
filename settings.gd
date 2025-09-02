extends Node2D

func _ready():
	if (!Global.visible_joystick):
		$VBoxContainer/VisibleJoystick.button_pressed = true


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")


func _on_visible_joystick_toggled(toggled_on: bool) -> void:
	Global.visible_joystick = !toggled_on
