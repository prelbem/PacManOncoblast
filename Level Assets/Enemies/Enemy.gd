extends Area2D
class_name Enemy
@export var speed: float = 100.0
@export var pathfinder: PathfindingManager
@export var player: Area2D
@export var walls: TileMapLayer

@onready var gate = %Gate
@onready var warpLeft = %WarpLeft
@onready var warpRight = %WarpRight

var path : PackedVector2Array
var spawnpoint: Vector2

func _ready():
	spawnpoint = global_position - Vector2(0, 32)
	$StateMachine.init(self)

func scare():
	if $StateMachine.current_state != $StateMachine.get_node("Waiting"):
		$StateMachine.change_state($StateMachine/Scared)

func _process_physics(delta: float) -> void:
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false

func _on_start_delay_timeout() -> void:
	pass
