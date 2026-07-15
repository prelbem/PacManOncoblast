extends EnemyMove
@export var next_state: State

func enter():
	parent.get_node("StartDelay").start()

##Goes up and down.
func find_path():
	var path = []
	if parent.global_position.distance_to(parent.spawnpoint) == 0:
		path = parent.pathfinder.getPath(parent.global_position, parent.global_position + Vector2(0, 32))
	else:
		path = parent.pathfinder.getPath(parent.global_position, parent.spawnpoint)
	parent.path = path
	
func process_physics(delta):
	if parent.get_node("StartDelay").time_left <= 0:
		return next_state
	else:
		return super(delta);
