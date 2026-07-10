@abstract
class_name EnemyMove extends State
@export var speed: float = 70

var active = false;

func enter():
	active = true;
	super()

func exit():
	active = false;
	super();

@abstract
func find_path()

func on_area_entered(area: Area2D):
	if (area.is_in_group("Player")):
		var player: Player = area;
		player.hit();

func process_physics(delta):
	if parent.path.is_empty():
		find_path()
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)
	return;
