extends EnemyMove
func find_path():
	var answerDots = get_tree().get_nodes_in_group("Answer Dots")
	var randomCoord = answerDots[randi() % answerDots.size()].global_position
	parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord)
