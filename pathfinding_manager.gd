class_name PathfindingManager
extends Node2D

var astarGrid = AStarGrid2D.new()
var cell_size: int;
@export var tilemap: TileMapLayer

func setupGrid():
	astarGrid.region = tilemap.get_used_rect()
	astarGrid.cell_size = tilemap.tile_set.tile_size
	astarGrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astarGrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astarGrid.offset = Vector2(16, 16)
	astarGrid.update()
	
	#this HAS to come after updating astar grid
	var tilemapRect = tilemap.get_used_rect();
	for x in range(tilemapRect.position.x, tilemapRect.position.x + tilemapRect.size.x):
		for y in range(tilemapRect.position.y, tilemapRect.position.y + tilemapRect.size.y):
			if tilemap.get_cell_source_id(Vector2i(x, y)) == -1:
				astarGrid.set_point_solid(Vector2i(x, y))
				
	cell_size = astarGrid.cell_size.x
	
func getPath(start: Vector2i, end: Vector2i) -> PackedVector2Array:
	#var path : Array[Vector2] = []
	#for point in astarGrid.get_point_path(start/astarGrid.cell_size.x, end/astarGrid.cell_size.x):
	#	var currPoint = point
	#	path.append(currPoint)
	return astarGrid.get_point_path(start/cell_size, end/cell_size); 
	
func getPlayerPath(position: Vector2i, direction: Vector2i) -> PackedVector2Array:
	var point = position + direction * cell_size;
	while (astarGrid.is_in_boundsv(point/cell_size) 
	&& astarGrid.is_point_solid(point/cell_size)):
		point += direction * cell_size;
	
	return astarGrid.get_point_path(position/cell_size, point/cell_size);
	
func _ready():
	setupGrid()
