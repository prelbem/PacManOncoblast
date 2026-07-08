class_name EnemyMove extends State
@export var speed: float = 70

var active = false;

func enter():
	active = true;
	super()

func exit():
	active = false;
	super();

func find_path():
	pass

func process_physics(delta):
	if parent.path.is_empty():
		find_path()
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)
	return;

func _on_enemy_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player") and active):
		body._on_player_hit();
