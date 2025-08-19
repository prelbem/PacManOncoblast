extends CharacterBody2D
@export var speed = 200

var movement_queue = ""
var can_move = true
var upWall = false
var rightWall = false
var leftWall = false
var downWall = false
var score: int = 0
var lives = 3
var preVelocity: Vector2;

signal update_lives(lives)
signal player_death
signal answer_dot_eaten(answer)

func _physics_process(delta):
	#continuously tries to move in the option the player pressed
	if (can_move):
		if movement_queue != "":
			if movement_queue == "move_right":
				if (!rightWall):
					velocity.x = 1
					velocity.y = 0
					movement_queue = ""
					$AnimatedSprite2D.play("default")
					$AnimatedSprite2D.rotation = 0
			elif movement_queue == "move_left":
				if (!leftWall):
					velocity.x = -1
					velocity.y = 0
					movement_queue = ""
					$AnimatedSprite2D.play("default")
					$AnimatedSprite2D.rotation = PI
			elif movement_queue == "move_up":
				if (!upWall):
					velocity.y = -1
					velocity.x = 0
					movement_queue = ""
					$AnimatedSprite2D.play("default")
					$AnimatedSprite2D.rotation = PI * 3/2
			elif movement_queue == "move_down":
				if (!downWall):
					velocity.y = 1
					velocity.x = 0
					movement_queue = ""
					$AnimatedSprite2D.play("default")
					$AnimatedSprite2D.rotation = PI / 2
		
		if (Input.is_action_pressed("ui_right")):
			if (!rightWall):
				velocity.x = 1
				velocity.y = 0
				movement_queue = ""
				$AnimatedSprite2D.play("default")
				$AnimatedSprite2D.rotation = 0
			else:
				movement_queue = "move_right"
		if (Input.is_action_pressed("ui_left")):
			if (!leftWall):
				velocity.x = -1
				velocity.y = 0
				movement_queue = ""
				$AnimatedSprite2D.play("default")
				$AnimatedSprite2D.rotation = PI
			else:
				movement_queue = "move_left"
		if (Input.is_action_pressed("ui_up")):
			if (!upWall):
				velocity.y = -1
				velocity.x = 0
				movement_queue = ""
				$AnimatedSprite2D.play("default")
				$AnimatedSprite2D.rotation = PI * 3/2
			else:
				movement_queue = "move_up"
		if (Input.is_action_pressed("ui_down")):
			if (!downWall):
				velocity.y = 1
				velocity.x = 0
				$AnimatedSprite2D.play("default")
				$AnimatedSprite2D.rotation = PI / 2
				movement_queue = ""
			else:
				movement_queue = "move_down"
	
	if (velocity.length() > 0):
		#prevent the player from colliding into walls and throwing off right angles
		if (velocity.y >= 1 and downWall):
			$AnimatedSprite2D.pause()
			velocity = Vector2(0, 0)
			movement_queue = ""
		if (velocity.y <= -1 and upWall):
			$AnimatedSprite2D.pause()
			velocity = Vector2(0, 0)
			movement_queue = ""
		if (velocity.x <= -1 and leftWall):
			$AnimatedSprite2D.pause()
			velocity = Vector2(0, 0)
			movement_queue = ""
		if (velocity.x >= 1 and rightWall):
			$AnimatedSprite2D.pause()
			velocity = Vector2(0, 0)
			movement_queue = ""
		velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		movement_queue = ""

func _on_right_detect_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		rightWall = true

func _on_right_detect_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		rightWall = false

func _on_up_detect_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		upWall = true

func _on_up_detect_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		upWall = false

func _on_left_detect_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		leftWall = true

func _on_left_detect_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		leftWall = false

func _on_down_detect_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		downWall = true

func _on_down_detect_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Walls")):
		downWall = false

func _on_player_body_area_entered(area: Area2D) -> void:
	if area.is_in_group("Dots"):
		score += 1
		area.queue_free()
	if area.is_in_group("Answer Dots"):
		if area.isAnswer:
			score += 10
			answer_dot_eaten.emit(area.isAnswer)
		else:
			score -= 5
		area.queue_free()
	%HUD.get_node("Score").text = str(score)

#get that retro player hit feel, pauses the game upon a hit and then flashes after
func _on_player_hit() -> void:
	if ($IFrames.time_left <= 0):
		lives -= 1;
		if (lives <= 0):
			kill_player()
			return
		update_lives.emit(lives)
		$IFrames.start()
		$DamagePause.start()
		process_mode = Node.PROCESS_MODE_ALWAYS
		preVelocity = velocity
		velocity = Vector2(0, 0)
		can_move = false
		visible = false
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
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_PAUSABLE
	velocity = preVelocity
	$DamageFlash.start()
	visible = true
	can_move = true

func _on_i_frames_timeout() -> void:
	$DamageFlash.stop()
	visible = true

func _on_damage_flash_timeout() -> void:
	visible = !visible
