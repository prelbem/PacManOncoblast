extends Enemy
func findPath():
	var answerDots = get_tree().get_nodes_in_group("Answer Dots")
	var randomCoord = answerDots[randi() % answerDots.size()].global_position
	path = pathfinder.getPath(global_position, randomCoord);
