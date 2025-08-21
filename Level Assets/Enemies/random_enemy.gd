extends Enemy
@onready var cells = %Walls.get_used_cells()
@onready var warpLeft = %WarpLeft
@onready var warpRight = %WarpRight
@onready var gate = %Gate
func _ready():
	$StateMachine.init(self)

func _process(delta):
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false
