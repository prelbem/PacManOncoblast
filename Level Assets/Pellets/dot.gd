extends Area2D

@export var value: int

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		get_parent().player.updateScore(value)
		queue_free()
