extends Area2D

@export var value: int

##If the area is a player, it gives the player points and deletes itself.
func _on_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Player")):
		get_parent().playerManager.updateScore(value)
		queue_free()
