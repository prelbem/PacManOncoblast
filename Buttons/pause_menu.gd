extends Control
func _ready():
	pass


func _on_continue_pressed() -> void:
	var player = get_node("../../Player")
	var damage_timer: Timer = player.get_node("Pause")
	#if damage pause is inactive
	if damage_timer.time_left <= 0:
		#to unpause
		get_tree().paused = false
	#if damage pause is active
	else:
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		#damage_timer.paused = false
		#player.get_node("DamageFlash").paused = false
	visible = false
	get_node("../../HUD/ScreenTint").visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
