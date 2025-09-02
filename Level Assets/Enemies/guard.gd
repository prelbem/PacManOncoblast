extends EnemyMove
func find_path():
	var answerDots = get_tree().get_nodes_in_group("Answer Dots")
	if answerDots.size() > 1:
		var randomCoord = answerDots[randi() % answerDots.size()].global_position
		parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord)
	else:
		var player = parent.player
		var direct = player.queue_dir
		parent.path = parent.pathfinder.getPath(parent.global_position, player.global_position + direct * 64)
