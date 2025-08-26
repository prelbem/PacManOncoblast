extends State
@export var idle_state: State
@export var eaten_state: State
var eaten = false
func enter():
	parent.path.clear()
	$ScaredTimer.start()
	
func exit():
	parent.path.clear()

func find_path():
	var player_cell_coord = parent.walls.local_to_map(parent.player.global_position)
	
func process_physics(delta):
	if eaten:
		return eaten_state
	if $ScaredTimer.time_left <= 0:
		return idle_state.next_state
	#super(delta)


func _on_test_enemy_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		eaten = true
