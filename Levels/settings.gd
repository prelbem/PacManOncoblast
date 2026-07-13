extends ColorRect

@export var titleScreen: PackedScene

func _ready():
	if (!Global.VISIBLE_JOYSTICK):
		$VBoxContainer/VisibleJoystick.button_pressed = true

func _on_back_pressed() -> void:
	GameManager.change_scene(GameManager.Scenes.TITLE_SCREEN)

func _on_visible_joystick_toggled(toggled_on: bool) -> void:
	Global.VISIBLE_JOYSTICK = !toggled_on
