extends EnemyMove
func find_path():
	var pathfinder = parent.pathfinder
	var player = parent.player
	var warpLeft = parent.warpLeft
	var warpRight = parent.warpRight
	var path: PackedVector2Array = pathfinder.getPath(parent.global_position, player.global_position)
	var warpLeftPath: PackedVector2Array = (pathfinder.getPath(parent.global_position, warpLeft.global_position) 
		+ pathfinder.getPath(warpRight.global_position, player.global_position))
	var warpRightPath: PackedVector2Array = (pathfinder.getPath(parent.global_position, warpRight.global_position) 
		+ pathfinder.getPath(warpLeft.global_position, player.global_position))
	
	if (path_length(path) > path_length(warpLeftPath)):
		path = warpLeftPath
	if (path_length(path) > path_length(warpRightPath)):
		path = warpRightPath
	parent.path = path

func path_length(path: PackedVector2Array) -> int:
	var result = 0;
	for i in path.size() - 1:
		result += path.get(i + 1).distance_to(path.get(i))
	return result;
