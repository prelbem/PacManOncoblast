extends Area2D
@export var speed: float = 100.0
@export var pathfinder: PathfindingManager
@export var playerManager: PlayerManager
@export var walls: TileMapLayer

@onready var gate = %Gate
@onready var warpLeft = %WarpLeft
@onready var warpRight = %WarpRight

var path : PackedVector2Array
var spawnpoint: Vector2

func _ready():
	spawnpoint = global_position
	$StateMachine.init(self)

##Changes the state to scared.
func scare():
	if $StateMachine.current_state != $StateMachine.get_node("Waiting"):
		$StateMachine.change_state($StateMachine/Scared)

func _process(delta: float) -> void:
	$StateMachine.process_physics(delta)

func _process_physics(delta: float) -> void:
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false

func _on_area_entered(area: Area2D) -> void:
	$StateMachine.current_state.on_area_entered(area);
