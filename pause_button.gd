extends TouchScreenButton


func _on_pressed() -> void:
	var player = get_node("../../Player")
	var damage_timer: Timer = player.get_node("DamagePause")
	#if damage pause is inactive
	if damage_timer.time_left <= 0:
		#to pause
		if (!get_tree().paused):
			get_tree().paused = true
	#if damage pause is active
	else:
		damage_timer.paused = true
	get_node("../../HUD/PauseMenu").visible = true
	get_node("../../HUD/ScreenTint").visible = true
