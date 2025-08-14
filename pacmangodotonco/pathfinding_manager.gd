class_name PathfindingManager
extends Node2D

var astarGrid = AStarGrid2D.new()
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
				
	
func getPath(start: Vector2i, end: Vector2i) -> Array[Vector2]:
	var path : Array[Vector2] = []
	for point in astarGrid.get_point_path(start/32, end/32):
		var currPoint = point
		path.append(currPoint)
	#print_debug(path)
	return path; 
	
func _ready():
	setupGrid()
