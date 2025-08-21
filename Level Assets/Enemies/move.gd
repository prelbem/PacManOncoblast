class_name EnemyMove extends State
func find_path():
	pass

func process_physics(delta):
	if parent.path.is_empty():
		find_path()
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], parent.speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)
