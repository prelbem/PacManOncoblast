extends EnemyMove
@export var next_state: State
@export var eaten_state: State

var eaten = false
func enter():
	super()
	parent.path.clear()
	$ScaredTimer.start()
	parent.get_node("AnimatedSprite2D").play("scared")
		
func exit():
	super()
	eaten = false;
	parent.path.clear()
	parent.get_node("AnimatedSprite2D").play("default")


func find_path():
	var cells = parent.walls.get_used_cells()
	var player_cell_coord = parent.walls.local_to_map(parent.playerManager.get_global_position())
	var randomCoord = cells[randi() % cells.size()] * 32 + Vector2i(16, 16)
	while !(randomCoord.distance_to(parent.warpLeft.global_position) > 32 and randomCoord.distance_to(parent.warpRight.global_position) > 32 and randomCoord.y > parent.gate.global_position.y):
		randomCoord = cells[randi() % cells.size()] * 32 + Vector2i(16, 16)
	parent.path = parent.pathfinder.getPath(parent.global_position, randomCoord);
	
func process_physics(delta):
	if eaten:
		return eaten_state
	if $ScaredTimer.time_left <= 0:
		return next_state
	return super(delta)

func on_area_entered(area: Area2D):
	if (area.is_in_group("Player")):
		parent.playerManager.updateScore(10)
		parent.playerManager.freeze_frame(0.5)
		eaten = true
