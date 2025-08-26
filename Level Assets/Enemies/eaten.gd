extends EnemyMove
@export var idle_state: State
func enter():
	parent.path = parent.pathfinder.getPath(parent.global_position, parent.spawnpoint)

func process_physics(delta):
	if parent.path.is_empty():
		return idle_state
	parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
	if parent.global_position == parent.path[0]:
		parent.path.remove_at(0)
