extends CharacterBody2D
class_name Enemy
@export var speed: float = 100.0
@export var pathfinder: PathfindingManager

signal player_hit

var path : Array[Vector2]
func findPath():
	path = pathfinder.getPath(global_position, %Player.global_position)

func _process(delta: float) -> void:
	if path.is_empty():
		findPath()
	else:
		global_position = global_position.move_toward(path[0], speed * delta)
		if global_position == path[0]:
			path.remove_at(0)
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		player_hit.emit()


func _on_player_death() -> void:
	visible = false
