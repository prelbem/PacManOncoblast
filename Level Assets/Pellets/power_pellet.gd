extends Area2D
signal power_pellet_eaten

func _on_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Player")):
		get_tree().call_group("Enemies", "scare")
		area.pellet_power = true
		area.get_node("PelletPower").start()
		queue_free()
