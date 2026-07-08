extends Area2D
signal power_pellet_eaten


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		get_tree().call_group("Enemies", "scare")
		body.pellet_power = true
		body.get_node("PelletPower").start()
		queue_free()
