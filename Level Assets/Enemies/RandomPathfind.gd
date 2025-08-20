extends Pathfind
func process_physics(delta):
	var randomCoord = parent.cells[randi() % parent.cells.size()] * 32 + Vector2i(16, 16)
	parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord);
	return chase_state
