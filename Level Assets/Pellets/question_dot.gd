extends "res://Level Assets/Pellets/dot.gd"

@onready var questionScreen : PackedScene = preload("res://QuestionScreen.tscn");

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		var screen = questionScreen.instantiate();
		get_tree().current_scene.get_node("HUD").add_child(screen)
