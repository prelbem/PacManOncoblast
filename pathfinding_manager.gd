class_name PathfindingManager
extends Node2D

var astarGrid:AStarGrid2D
var astarMutex: Mutex
var cell_size: int;
@export var tilemap: TileMapLayer

##Sets up the astarGrid, setting a point at every tilemap cell.
func setupGrid():
	astarGrid = AStarGrid2D.new();
	astarMutex = Mutex.new();
	astarGrid.region = tilemap.get_used_rect()
	astarGrid.cell_size = tilemap.tile_set.tile_size
	astarGrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astarGrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astarGrid.offset = Vector2(16, 0)
	#astarGrid.jumping_enabled = true;
	astarGrid.update()
	
	#this HAS to come after updating astar grid
	var tilemapRect = tilemap.get_used_rect();
	for x in range(tilemapRect.position.x, tilemapRect.position.x + tilemapRect.size.x):
		for y in range(tilemapRect.position.y, tilemapRect.position.y + tilemapRect.size.y):
			if tilemap.get_cell_source_id(Vector2i(x, y)) == -1:
				astarGrid.set_point_solid(Vector2i(x, y))
				
	cell_size = astarGrid.cell_size.x
	
##Gets a path from the start to the end point.
func getPath(start: Vector2, end: Vector2) -> PackedVector2Array:
	astarMutex.lock();
	var result = astarGrid.get_point_path(start/cell_size, end/cell_size)
	astarMutex.unlock();
	return result; 

##Gets the path that the player should take.
## [br][param position] - The position of the player
## [br][param new_direction] - The new direction the player wants to go in.
## [br][param old_direction] - The direction the player is currently facing.
## [br][br]@returns - The first available path that takes a turn in the [param new_direction]. If there is no such path, it returns an empty array.
func getPlayerPath(position: Vector2, new_direction: Vector2, curr_direction: Vector2) -> PackedVector2Array:
	var point: Vector2 = position/cell_size + new_direction.normalized();
	while (astarGrid.is_in_boundsv(point) 
	&& astarGrid.is_point_solid(point)):
		point += curr_direction.normalized();
	if (point.y * cell_size <= %Gate.global_position.y):
		return [];

	if (astarGrid.is_in_boundsv(point)):
		astarMutex.lock()
		var path = astarGrid.get_point_path(position/cell_size, point);
		astarMutex.unlock()
		if path.size() >= 3:
			path.remove_at(0)
		return path;
	else:
		return [];
	
func _ready():
	setupGrid()
