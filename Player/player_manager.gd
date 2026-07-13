extends Node
class_name PlayerManager

@export var player: Player

signal player_death
signal update_lives(lives)

var score: int = 0
var lives = 3

func get_global_position() -> Vector2:
	return player.global_position

func _on_i_frames_timeout() -> void:
	$DamageFlash.stop()
	player.visible = true

func _on_damage_flash_timeout() -> void:
	player.visible = !player.visible

func _on_pellet_power_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		var state_machine = enemy.get_node("StateMachine")
		if state_machine.current_state == state_machine.get_node("Waiting"):
			state_machine.change_state(state_machine.get_node("Waiting").next_state);

#get that retro player hit feel, pauses the game upon a hit and then flashes after
func hit() -> void:
	if (get_node("IFrames").time_left <= 0):
		lives -= 1;
		if (lives <= 0):
			player.rotation = 0
			kill_player()
			return
		update_lives.emit(lives)
		player.visible = false
		
		GameManager.freeze_frame()
		
		$IFrames.start()
		$DamageFlash.start()

func kill_player():
	player.can_move = false
	player.rotation = 0
	player.get_node("AnimatedSprite2D").play("death")
	player_death.emit()

func updateScore(val):
	score += val
	%HUD.get_node("Score").text = str(score)

func _on_death_animation_finished() -> void:
	GameManager.change_scene(GameManager.Scenes.GAME_OVER)
