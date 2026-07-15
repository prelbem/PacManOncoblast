extends EnemyMove
##Finds a path to the player, and does allow the enemy to chase the player through the warp points.
func find_path():
	var pathfinder = parent.pathfinder
	var playerManager = parent.playerManager
	var warpLeft = parent.warpLeft
	var warpRight = parent.warpRight
	
	var endpoint = playerManager.get_global_position();
	var path: PackedVector2Array = pathfinder.getPath(parent.global_position, endpoint)
	var warpLeftPath: PackedVector2Array = pathfinder.getPath(parent.global_position, warpLeft.global_position) 
	warpLeftPath.append_array(pathfinder.getPath(warpLeft.global_position, endpoint))
	var warpRightPath: PackedVector2Array = pathfinder.getPath(parent.global_position, warpRight.global_position) 
	warpRightPath.append_array(pathfinder.getPath(warpRight.global_position, endpoint))
	if (path_length(path) > path_length(warpLeftPath)):
		path = warpLeftPath
	if (path_length(path) > path_length(warpRightPath)):
		path = warpRightPath
	parent.path = path

##Finds the length of a path assuming the path takes straight lines between each node.
## [br][param path]- The path to find the length of.
## [br][br]@returns - An int representing the length of the path.
func path_length(path: PackedVector2Array) -> int:
	var result = 0;
	for i in path.size() - 1:
		result += path.get(i + 1).distance_to(path.get(i))
	return result;
