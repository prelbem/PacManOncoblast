extends EnemyMove
@export var next_state: State

func find_path():
	var path = parent.pathfinder.getPath(parent.global_position, parent.global_position + Vector2(0, 32));
	if path.is_empty():
		path = parent.pathfinder.getPath(parent.global_position, parent.global_position - Vector2(0, 32))
	parent.path = path
	
func process_physics(delta):
	if parent.get_node("StartDelay").time_left <= 0:
		return next_state
	else:
		super(delta)
