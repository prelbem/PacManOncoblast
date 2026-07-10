extends Area2D
class_name Player

@export var speed = 200
@export var pathfindManager: PathfindingManager;
var queue_dir: Vector2i = Vector2i.RIGHT;
var can_move = true
var score: int = 0
var lives = 3
var preVelocity: Vector2;
var path: PackedVector2Array;

var damage_flash = false
var pellet_power = false

signal update_lives(lives)
signal player_death

func _ready():
	path = [];
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	#continuously tries to move in the option the player pressed
	if (can_move):			
		if (Input.is_action_just_pressed("ui_right")):
			queue_dir = Vector2i.RIGHT
			updatePath();
		if (Input.is_action_just_pressed("ui_left")):
			queue_dir = Vector2i.LEFT
			updatePath();
		if (Input.is_action_just_pressed("ui_up")):
			queue_dir = Vector2i.UP
			updatePath();
		if (Input.is_action_just_pressed("ui_down")):
			queue_dir = Vector2i.DOWN
			updatePath();
			
		if path.is_empty():
			$AnimatedSprite2D.pause()
			updatePath();
		else:
			if !$AnimatedSprite2D.is_playing():
				$AnimatedSprite2D.play();
			if global_position == path.get(0):
				path.remove_at(0)
				if (path.is_empty()):
					updatePath()
			else:
				var new_position: Vector2 = global_position.move_toward(path[0], speed * delta)
				rotation = (new_position - global_position).angle();
				global_position = new_position

func updatePath():
	path = pathfindManager.getPlayerPath(global_position, queue_dir, Vector2.from_angle(rotation))

func updateScore(val):
	score += val
	%HUD.get_node("Score").text = str(score)

#get that retro player hit feel, pauses the game upon a hit and then flashes after
func hit() -> void:
	if ($IFrames.time_left <= 0):
		lives -= 1;
		if (lives <= 0):
			rotation = 0
			kill_player()
			return
		update_lives.emit(lives)
		freeze_frame()
		damage_flash = true
		get_tree().paused = true

func freeze_frame(time = 1):
	$AudioStreamPlayer2D.stop()
	$Pause.wait_time = time
	$Pause.start()
	process_mode = Node.PROCESS_MODE_ALWAYS
	can_move = false
	visible = false
	get_tree().paused = true

func kill_player():
	can_move = false
	$AnimatedSprite2D.rotation = 0
	$AnimatedSprite2D.play("death")
	player_death.emit()

func _on_death_animation_finished() -> void:
	get_tree().change_scene_to_file("res://GameOver.tscn")

func _on_damage_pause_timeout() -> void:
	$AudioStreamPlayer2D.play()
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_PAUSABLE
	if (damage_flash):
		$IFrames.start()
		$DamageFlash.start()
	damage_flash = false
	visible = true
	can_move = true

func _on_i_frames_timeout() -> void:
	$DamageFlash.stop()
	visible = true

func _on_damage_flash_timeout() -> void:
	visible = !visible

func _on_pellet_power_timeout() -> void:
	pellet_power = false
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		var state_machine = enemy.get_node("StateMachine")
		if state_machine.current_state == state_machine.get_node("Waiting"):
			state_machine.change_state(state_machine.get_node("Waiting").next_state);
