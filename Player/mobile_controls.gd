extends Control
var clicked = false
@export var sprite_size: int
@onready var spawnpoint = global_position - Vector2(sprite_size/2, sprite_size/2)

func _ready():
	visible = Global.visible_joystick

func _process(delta):
	if Input.is_action_just_pressed("clicked"):
		$Base.global_position = get_viewport().get_mouse_position()
		clicked = true
		
	if Input.is_action_just_released("clicked"):
		$Base.global_position = spawnpoint
		$Base/Joystick.global_position = $Base.global_position + Vector2(sprite_size/4, sprite_size/4)
		clicked = false
		
	if clicked:
		var mouse_pos = get_viewport().get_mouse_position()
		var distance = min(64, mouse_pos.distance_to($Base.global_position - Vector2(sprite_size/4, sprite_size/4)))
		var direct = mouse_pos - $Base.global_position
		direct = direct.normalized()
		$Base/Joystick.global_position = $Base.global_position + Vector2(sprite_size/4, sprite_size/4) + direct * distance
		var angle_input = snapped(direct.angle(), PI/2)
		if (angle_input == 0):
			Input.action_press("ui_right")
			Input.action_release("ui_right")
		if (angle_input == -PI/2):
			Input.action_press("ui_up")
			Input.action_release("ui_up")
		if (angle_input == PI):
			Input.action_press("ui_left")
			Input.action_release("ui_left")
		if (angle_input == PI/2):
			Input.action_press("ui_down")
			Input.action_release("ui_down")
		
