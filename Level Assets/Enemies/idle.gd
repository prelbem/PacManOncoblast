extends EnemyMove
@export var next_state: State

var spawnPoint: Vector2

func enter():
	parent.get_node("StartDelay").start()
	spawnPoint = parent.global_position

func exit():
	parent.path.clear()

func find_path():
	var path = []
	if parent.global_position.distance_to(spawnPoint) == 0:
		path = parent.pathfinder.getPath(parent.global_position, parent.global_position - Vector2(0, 16))
	else:
		path = parent.pathfinder.getPath(parent.global_position, spawnPoint)
	parent.path = path
	
func process_physics(delta):
	if parent.get_node("StartDelay").time_left <= 0:
		return next_state
	else:
		if parent.path.is_empty():
			find_path()
		else:
			parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
			if parent.global_position == parent.path[0]:
				parent.path.remove_at(0)
