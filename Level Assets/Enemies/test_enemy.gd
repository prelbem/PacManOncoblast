extends Area2D
class_name Enemy
@export var speed: float = 100.0
@export var pathfinder: PathfindingManager

var path : Array[Vector2]

func _ready():
	$StateMachine.init(self)

func _process_physics(delta: float) -> void:
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false
