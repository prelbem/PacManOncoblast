extends Area2D
class_name Player

@export var speed = 200
@export var pathfindManager: PathfindingManager;

var queue_dir: Vector2i = Vector2i.RIGHT;
var can_move = true
var score: int = 0
var lives = 3
var path: PackedVector2Array;

func _ready():
	path = [];
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	#continuously tries to move in the option the player pressed
	if (can_move):			
		if (Input.is_action_just_pressed("ui_right")):
			queue_dir = Vector2i.RIGHT
		if (Input.is_action_just_pressed("ui_left")):
			queue_dir = Vector2i.LEFT
		if (Input.is_action_just_pressed("ui_up")):
			queue_dir = Vector2i.UP
		if (Input.is_action_just_pressed("ui_down")):
			queue_dir = Vector2i.DOWN
		
		updatePath()
		
		if path.is_empty():
			$AnimatedSprite2D.pause()
			$AudioStreamPlayer2D.stop()
			updatePath();
		else:
			if !$AnimatedSprite2D.is_playing():
				$AnimatedSprite2D.play();
				$AudioStreamPlayer2D.play()
			if global_position == path.get(0):
				path.remove_at(0)
			else:
				var new_position: Vector2 = global_position.move_toward(path[0], speed * delta)
				rotation = (new_position - global_position).angle();
				global_position = new_position

func updatePath():
	if path.is_empty():
		path = pathfindManager.getPlayerPath(global_position, queue_dir, Vector2.from_angle(rotation))
	else: 
		var new_path = pathfindManager.getPlayerPath(global_position, queue_dir, Vector2.from_angle(rotation))
		if !new_path.is_empty() && new_path.get(new_path.size() - 1) != path.get(path.size() - 1):
			path = new_path

func on_death_animation_finished():
	GameManager.change_scene(GameManager.Scenes.GAME_OVER)
