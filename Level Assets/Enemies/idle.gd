extends EnemyMove
@export var next_state: State

var upPath = false

func enter():
	parent.get_node("StartDelay").start()

func exit():
	parent.path.clear()

func find_path():
	var path = []
	if upPath:
		path = parent.pathfinder.getPath(parent.global_position, parent.global_position - Vector2(0, 32));
	else:
		path = parent.pathfinder.getPath(parent.global_position, parent.global_position + Vector2(0, 32))
	upPath = !upPath
	parent.path = path
	
func process_physics(delta):
	if parent.get_node("StartDelay").time_left <= 0:
		return next_state
	else:
		super(delta)
