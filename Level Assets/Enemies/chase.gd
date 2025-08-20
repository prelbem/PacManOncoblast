extends State
@export var pathfind_state: State

func process_physics(delta):
	if parent.path.is_empty():
		return pathfind_state
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], parent.speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)
