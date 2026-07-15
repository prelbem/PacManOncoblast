@abstract
class_name EnemyMove extends State
@export var speed: float = 70

##Sets the path of the enemy. 
@abstract
func find_path()

##Checks to see if the area entered is the player. If it is, it hits the player.
func on_area_entered(area: Area2D):
	if (area.is_in_group("Player")):
		parent.playerManager.hit();

##If the path is empty, it finds a new path. Otherwise, it moves toward the first
## node in the path.
func process_physics(delta):
	if parent.path.is_empty():
		find_path()
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)
	return;
