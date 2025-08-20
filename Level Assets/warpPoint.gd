extends Marker2D

@export var warpPoint: Marker2D
var just_warped = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (not just_warped):
		if (body.is_in_group("Player") or body.is_in_group("Enemies")):
			body.global_position = warpPoint.global_position	
			warpPoint.just_warped = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Player") or body.is_in_group("Enemies")):
		just_warped = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (not just_warped):
		if (area.is_in_group("Enemies")):
			area.global_position = warpPoint.global_position	
			area.findPath()
			warpPoint.just_warped = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if (area.is_in_group("Enemies")):
		just_warped = false
