extends EnemyMove
func find_path():
	var pathfinder = parent.pathfinder
	var player = parent.player
	var warpLeft = parent.warpLeft
	var warpRight = parent.warpRight
	var path = pathfinder.getPath(parent.global_position, player.global_position)
	var warpLeftPath = pathfinder.getPath(parent.global_position, warpLeft.global_position) + pathfinder.getPath(warpRight.global_position, player.global_position)
	var warpRightPath = pathfinder.getPath(parent.global_position, warpRight.global_position) + pathfinder.getPath(warpRight.global_position, player.global_position)
	if (path.size() > warpLeftPath.size()):
		path = warpLeftPath
	if (path.size() > warpRightPath.size()):
		path = warpRightPath
	#manually correct top pathfinding to player
	if (path.size() > 0 and path[path.size() - 1].y == -48.0):
		path[path.size() - 1].y = -80
	parent.path = path

func process_physics(delta):
	if parent.path.is_empty():
		find_path()
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], parent.speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)
