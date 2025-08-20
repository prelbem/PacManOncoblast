extends State
class_name Pathfind

@export var chase_state: State
func process_physics(delta):
	parent.path = parent.pathfinder.getPath(parent.global_position, %Player.global_position)
	return chase_state
