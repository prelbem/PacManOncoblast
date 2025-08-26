class_name EnemyMove extends State
@export var speed: float = 70

func find_path():
	pass

func process_physics(delta):
	if parent.path.is_empty():
		find_path()
	else:
		parent.global_position = parent.global_position.move_toward(parent.path[0], speed * delta)
		if parent.global_position == parent.path[0]:
			parent.path.remove_at(0)

func _on_enemy_body_entered(body: Node2D):
	if (body.is_in_group("Player")):
		if (not body.pellet_power):
			body._on_player_hit()
