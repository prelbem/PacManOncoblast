extends TileMapLayer
@onready var dot = preload("res://Level Assets/dot.tscn");
@onready var answerDot = preload("res://Level Assets/AnswerDot.tscn")
@onready var powerPellet = preload("res://Level Assets/power_pellet.tscn")
@onready var player = %Player
var correct_answers = 0

const left_column = 176.0;
const right_column = 560.0;

func setupDots():
	for child in get_children():
		if (!child.is_in_group("Power Pellet")):
			call_deferred("remove_child", child)
			child.queue_free()
		
	var cells = get_used_cells()
	for cell in cells:
		var dotChild = dot.instantiate()
		var pos = Vector2(cell * tile_set.tile_size + Vector2i(16, 16));
		#don't spawn dots above the gate or next to the warp markers
		if (pos.distance_to(%WarpLeft.global_position) > 32 and pos.distance_to(%WarpRight.global_position) > 32 and pos.y > %Gate.position.y):
			call_deferred("add_child", dotChild)
			dotChild.global_position = pos
			dotChild.add_to_group("Dots")
		
func setupAnswerDots():
	var questionIndex = randi() % Global.questions.size()
	var dots = get_children()
	var question = Global.questions[questionIndex]
	%HUD.get_node("Question").text = question
	
	for currDot: Node2D in dots:
		if (currDot.global_position.distance_to(player.global_position) <= 64 
			|| currDot.global_position.x == left_column
			|| currDot.global_position.x == right_column):
			dots.erase(currDot);
	
	addTrueAnswerDot(questionIndex, dots)
	addFalseAnswerDots(questionIndex, dots)

func addTrueAnswerDot(questionIndex, dots):
	var trueAnswer = Global.trueAnswers[questionIndex]
	var dot: Node2D = dots.pick_random();
	dots.erase(dot);
	var trueDot = replaceDot(answerDot, dot)
	trueDot.changeAnswer(trueAnswer);
	trueDot.add_to_group("Answer Dots")
	
func addFalseAnswerDots(questionIndex, dots):
	var falseAnswers = Global.falseAnswers[questionIndex];
	for answer in falseAnswers:
		var dot: Node2D = dots.pick_random();
		dots.erase(dot);
		var falseDot = replaceDot(answerDot, dot);
		falseDot.changeAnswer(answer)
		falseDot.add_to_group("Answer Dots")
		falseDot.isAnswer = false;

func addPowerPellet():
	var currDot = get_children().pick_random();
	var currPellet = replaceDot(powerPellet, currDot);
	currPellet.add_to_group("Power Pellets")
	currDot.queue_free()

func replaceDot(toAdd: PackedScene, oldDot) -> Node2D:
	var newDot = toAdd.instantiate();
	newDot.global_position = oldDot.global_position;
	oldDot.queue_free();
	add_child(newDot);
	return newDot;

func _ready():
	setupDots()
	#setupAnswerDots()
	call_deferred("setupAnswerDots")
	#call_deferred("addPowerPellet")

func on_answer_dot_eaten(isAnswer):
	if (isAnswer):
		setupDots()
		correct_answers += 1
		call_deferred("setupAnswerDots")
		if (correct_answers >= 3):
			call_deferred("addPowerPellet")
			correct_answers = 0
	else:
		correct_answers -= 1
