extends Area2D
class_name Enemy
@export var speed: float = 100.0
@export var pathfinder: PathfindingManager
@export var player: CharacterBody2D
@export var walls: TileMapLayer

var path : Array[Vector2]
var spawnpoint: Vector2 = global_position - Vector2(0, 32)

func _ready():
	spawnpoint = global_position - Vector2(0, 32)
	$StateMachine.init(self)
func _process_physics(delta: float) -> void:
	$StateMachine.process_physics(delta)
	
func _on_player_death() -> void:
	visible = false


func _on_start_delay_timeout() -> void:
	$StartDelay.wait_time = 10
