extends Control

@export var titleScreen: PackedScene

func _ready():
	if (!Global.VISIBLE_JOYSTICK):
		$VBoxContainer/VisibleJoystick.button_pressed = true

func _on_back_pressed() -> void:
	$AnimationPlayer.play("to_menu")

func _on_visible_joystick_toggled(toggled_on: bool) -> void:
	Global.VISIBLE_JOYSTICK = !toggled_on


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"to_menu":
			GameManager.change_scene(GameManager.Scenes.TITLE_SCREEN)
