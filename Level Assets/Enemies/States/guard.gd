extends EnemyMove

##Gets a path to a random answer dot, if there are no answer dots left it doesn't pathfind.
func find_path():
	var answerDots = get_tree().get_nodes_in_group("Answer Dots")
	if answerDots.size() >= 1:
		var randomCoord = answerDots[randi() % answerDots.size()].global_position
		parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord)
