extends Enemy

func findPath():
	path = pathfinder.getPath(global_position, %Player.global_position)

func _process(delta: float) -> void:
	if path.size() == 0:
		findPath()
	else:
		global_position = global_position.move_toward(path[0], speed * delta)
		if global_position == path[0]:
			path.remove_at(0)
	
	move_and_slide()
