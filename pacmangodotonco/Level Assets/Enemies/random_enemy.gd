extends Enemy
@onready var cells = %Walls.get_used_cells()
func findPath():
	var randomCoord = cells[randi() % cells.size()] * %Walls.tile_set.tile_size + Vector2i(16, 16)
	path = pathfinder.getPath(global_position, randomCoord);
