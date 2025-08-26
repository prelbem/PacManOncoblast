extends Area2D
signal power_pellet_eaten


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		var enemies = get_tree().get_nodes_in_group("Enemies")
		body.pellet_power = true
		body.get_node("PelletPower").start()
		for enemy in enemies:
			var state_machine = enemy.get_node("StateMachine")
			if state_machine.current_state != state_machine.get_node("Idle"):
				state_machine.change_state(state_machine.get_node("Scared"))
		queue_free()
