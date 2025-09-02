extends Enemy

func _ready():
	super()
	spawnpoint = global_position - Vector2(0, 128)

func _process(delta):
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false
