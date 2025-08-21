extends Enemy
func _ready():
	$StateMachine.init(self)

func _process(delta):
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false
