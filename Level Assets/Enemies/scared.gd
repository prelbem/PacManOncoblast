extends EnemyMove
@export var idle_state: State
@export var eaten_state: State

var active = false
var eaten = false
func enter():
	active = true
	parent.path.clear()
	$ScaredTimer.start()
	parent.get_node("AnimatedSprite2D").play("scared")
	
func exit():
	active = false
	parent.path.clear()
	parent.get_node("AnimatedSprite2D").play("default")

func find_path():
	var cells = parent.walls.get_used_cells()
	var player_cell_coord = parent.walls.local_to_map(parent.player.global_position)
	var randomCoord = cells[randi() % cells.size()] * 32 + Vector2i(16, 16)
	while !(randomCoord.distance_to(parent.warpLeft.global_position) > 32 and randomCoord.distance_to(parent.warpRight.global_position) > 32 and randomCoord.y > parent.gate.global_position.y):
		randomCoord = cells[randi() % cells.size()] * 32 + Vector2i(16, 16)
	parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord);
	
func process_physics(delta):
	if eaten:
		return eaten_state
	if $ScaredTimer.time_left <= 0:
		return idle_state.next_state
	super(delta)


func _on_test_enemy_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player") and active):
		body.score += 10
		body.updateScore()
		body.on_eat_ghost()
		eaten = true
