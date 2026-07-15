extends Control
var clicked = false
@export var sprite_size: int
@onready var spawnpoint = global_position - Vector2(sprite_size/2, sprite_size/2)

func _ready():
	visible = Global.VISIBLE_JOYSTICK

func _process(delta):
	if Input.is_action_just_pressed("clicked"):
		global_position = get_viewport().get_mouse_position() - Vector2(sprite_size, sprite_size)/2
		clicked = true

	if Input.is_action_just_released("clicked"):
		global_position = spawnpoint + Vector2(sprite_size/4, sprite_size/4)
		clicked = false

	if clicked:
		var mouse_pos = get_viewport().get_mouse_position()
		var distance = min(64, mouse_pos.distance_to(global_position + Vector2(sprite_size, sprite_size)/4))
		var direct = mouse_pos - global_position
		direct = direct.normalized()
		$Joystick.global_position = global_position + direct * distance + Vector2(sprite_size, sprite_size)/4
		var angle_input = snapped(direct.angle(), PI/2)
		if (angle_input == 0):
			Input.action_press("ui_right")
			Input.action_release("ui_right")
		elif (angle_input == -PI/2):
			Input.action_press("ui_up")
			Input.action_release("ui_up")
		elif (angle_input == PI):
			Input.action_press("ui_left")
			Input.action_release("ui_left")
		elif (angle_input == PI/2):
			Input.action_press("ui_down")
			Input.action_release("ui_down")
