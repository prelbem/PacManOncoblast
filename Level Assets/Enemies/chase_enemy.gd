extends Enemy

func findPath():
	path = pathfinder.getPath(global_position, %Player.global_position)
	var warpLeftPath = pathfinder.getPath(global_position, %WarpLeft.global_position) + pathfinder.getPath(%WarpRight.global_position, %Player.global_position)
	var warpRightPath = pathfinder.getPath(global_position, %WarpRight.global_position) + pathfinder.getPath(%WarpLeft.global_position, %Player.global_position)
	if (path.size() > warpLeftPath.size()):
		path = warpLeftPath
	if (path.size() > warpRightPath.size()):
		path = warpRightPath
	#manually correct top pathfinding to player
	if (path.size() > 0 and path[path.size() - 1].y == -48.0):
		path[path.size() - 1].y = -80
		
func _process(delta: float) -> void:
	if path.size() == 0:
		findPath()
	else:
		global_position = global_position.move_toward(path[0], speed * delta)
		if global_position == path[0]:
			path.remove_at(0)
	
	#move_and_slide()
