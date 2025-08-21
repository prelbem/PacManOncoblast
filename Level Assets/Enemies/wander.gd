extends EnemyMove
func find_path():
	var randomCoord = parent.cells[randi() % parent.cells.size()] * 32 + Vector2i(16, 16)
	while !(randomCoord.distance_to(parent.warpLeft.global_position) > 32 and randomCoord.distance_to(parent.warpRight.global_position) > 32 and randomCoord.y > parent.gate.global_position.y):
		randomCoord = parent.cells[randi() % parent.cells.size()] * 32 + Vector2i(16, 16)
	parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord);
