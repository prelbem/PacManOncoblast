extends CharacterBody2D
@export var speed = 200

var shape_query = PhysicsShapeQueryParameters2D.new()
var queue_dir: Vector2
var movement_queue = ""
var can_move = true
var score: int = 0
var lives = 3
var preVelocity: Vector2;

var damage_flash = false
var pellet_power = false

signal update_lives(lives)
signal player_death
func _ready():
	shape_query.shape = $PlayerHitbox.shape
	shape_query.collide_with_areas = false
	shape_query.collide_with_bodies = true
	shape_query.collision_mask = 2

func _physics_process(delta):
	#continuously tries to move in the option the player pressed
	if (can_move):
		if (can_move_in_direction(queue_dir, delta)):
			velocity = queue_dir * speed
			rotation = velocity.angle()
			$AnimatedSprite2D.play("default")
			if !$AudioStreamPlayer2D.is_playing():
				$AudioStreamPlayer2D.play()

		if (Input.is_action_just_pressed("ui_right")):
			queue_dir = Vector2.RIGHT
		if (Input.is_action_just_pressed("ui_left")):
			queue_dir = Vector2.LEFT
		if (Input.is_action_just_pressed("ui_up")):
			queue_dir = Vector2.UP
		if (Input.is_action_just_pressed("ui_down")):
			queue_dir = Vector2.DOWN
	var collision = move_and_collide(velocity * delta)
	if (collision):
		$AnimatedSprite2D.pause()
		$AudioStreamPlayer2D.stop()

func can_move_in_direction(dir:Vector2, delta:float) -> bool:
	shape_query.transform = global_transform.translated(dir * speed * delta * 3)
	var result = get_world_2d().direct_space_state.intersect_shape(shape_query)
	return result.size() == 0

func updateScore(val):
	score += val
	%HUD.get_node("Score").text = str(score)

#get that retro player hit feel, pauses the game upon a hit and then flashes after
func _on_player_hit() -> void:
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
	preVelocity = velocity
	velocity = Vector2(0, 0)
	get_tree().paused = true

func kill_player():
	velocity = Vector2(0, 0)
	can_move = false
	movement_queue = ""
	$AnimatedSprite2D.rotation = 0
	$AnimatedSprite2D.play("death")
	player_death.emit()

func _on_death_animation_finished() -> void:
	get_tree().change_scene_to_file("res://game_over.tscn")

func _on_damage_pause_timeout() -> void:
	$AudioStreamPlayer2D.play()
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_PAUSABLE
	velocity = preVelocity
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
		if state_machine.current_state != state_machine.get_node("Idle"):
			state_machine.default_state.next_state
