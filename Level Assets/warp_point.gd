extends Marker2D

@export var warpPoint: Marker2D
var just_warped = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (not just_warped):
		if (area.is_in_group("Enemies") or area.is_in_group("Player")):
			area.global_position = warpPoint.global_position	
			warpPoint.just_warped = true
			area.path.clear()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (area.is_in_group("Enemies") or area.is_in_group("Player")):
		just_warped = false
