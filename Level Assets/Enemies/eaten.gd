extends EnemyMove
@export var next_state: State
func enter():
	parent.get_node("AnimatedSprite2D").play("eaten")
	parent.path = parent.pathfinder.getPath(parent.global_position, parent.spawnpoint)
	parent.monitoring = false

func exit():
	parent.get_node("AnimatedSprite2D").play("default")
	parent.monitoring = true

func find_path():
	pass

func process_physics(delta):
	if parent.path.is_empty():
		return next_state
	parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
	if parent.global_position == parent.path[0]:
		parent.path.remove_at(0)
	return null;
