extends Control
func _ready():
	pass


func _on_continue_pressed() -> void:
	var player = get_node("../../Player")
	var damage_timer: Timer = player.get_node("DamagePause")
	#if damage pause is inactive
	if damage_timer.time_left <= 0:
		#to unpause
		get_tree().paused = false
	#if damage pause is active
	else:
		damage_timer.paused = false
	visible = false
	get_node("../../HUD/ScreenTint").visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()
