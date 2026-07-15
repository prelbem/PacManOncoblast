extends TileMapLayer
@onready var dot: PackedScene = preload("res://Level Assets/Pellets/Dot.tscn");
@onready var answerDot: PackedScene = preload("res://Level Assets/Pellets/AnswerDot.tscn")
@onready var powerPellet: PackedScene = preload("res://Level Assets/Pellets/PowerPellet.tscn")
@onready var questionDot: PackedScene = preload("res://Level Assets/Pellets/QuestionDot.tscn")
@onready var questionScreen: PackedScene = preload("res://Level Assets/QuestionScreen.tscn")

@export var playerManager: PlayerManager

var correct_answers = 0

const left_column = 176.0;
const right_column = 560.0;

##Sets up the dots in the main level. Puts a dot on tiles below the ghost gate, and between the warp markers.
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
		if (pos.distance_to(%WarpLeft.global_position) > 64
			and pos.distance_to(%WarpRight.global_position) > 64
			and pos.y > %Gate.position.y):
			call_deferred("add_child", dotChild)
			dotChild.global_position = pos
			dotChild.add_to_group("Dots")

##Replaces dots with answer dots. 
##Doesn't use dots that are 64 pixels or closer to the player.
func setupAnswerDots():
	Global.QUESTION_INDEX = randi() % Global.getQuestionsSize()
	
	var answers: Array = Global.getFalseAnswers()[Global.QUESTION_INDEX].duplicate();
	answers.append(Global.getTrueAnswers()[Global.QUESTION_INDEX]);
	answers.shuffle();
	Global.ANSWER_SET = answers;
	
	for i in answers.size():
		if (Global.getTrueAnswers().has(answers[i])):
			Global.TRUE_LETTER = char(65 + i);
	
	var dots = get_children()
	var question = Global.getQuestions()[Global.QUESTION_INDEX]
	%HUD.get_node("Question").text = question
	
	for currDot: Node2D in dots:
		if (currDot.global_position.distance_to(playerManager.get_global_position()) <= 64):
			dots.erase(currDot);
	
	addTrueAnswerDot(dots)
	addFalseAnswerDots(dots)
	addQuestionDot(dots)

##Adds the true answer dot. [br]
##
## [param dots] - The array of dots that can be replaced. [br]
## @modifies [param dots] - Removes the dot that was replaced.
func addTrueAnswerDot(dots: Array):
	var trueAnswer = Global.getTrueAnswers()[Global.QUESTION_INDEX]
	var dot: Node2D = dots.pick_random();
	dots.erase(dot);
	var trueDot = replaceDot(answerDot, dot)
	trueDot.changeAnswer(Global.TRUE_LETTER);
	print(Global.TRUE_LETTER)
	trueDot.add_to_group("Answer Dots")

##Adds false answer dots. [br]
##
## [param dots] - The array of dots that can be replaced. [br]
## @modifies [param dots] - Removes the dots that was replaced.
func addFalseAnswerDots(dots: Array):
	var falseAnswers = Global.getFalseAnswers()[Global.QUESTION_INDEX];
	for i in falseAnswers.size():
		var dot: Node2D = dots.pick_random();
		dots.erase(dot);
		var falseDot = replaceDot(answerDot, dot);
		var letter = char(65 + i)
		if (65 + i >= ord(Global.TRUE_LETTER)):
			letter = char(66 + i);
		falseDot.changeAnswer(letter)
		falseDot.add_to_group("Answer Dots")
		falseDot.isAnswer = false;

##Replaces a random dot with a power pellet.
func addPowerPellet():
	var currDot = get_children().pick_random();
	var currPellet = replaceDot(powerPellet, currDot);
	currPellet.add_to_group("Power Pellets")

##Replaces a dot.
## [br][param toAdd] - The type of scene to replace the dot with.
## [br][param oldDot] - The dot to replace.
## [br][br] @returns - The new dot.
func replaceDot(toAdd: PackedScene, oldDot) -> Node2D:
	var newDot = toAdd.instantiate();
	newDot.global_position = oldDot.global_position - global_position;
	oldDot.queue_free();
	add_child(newDot);
	return newDot;

##Adds the question dot. [br]
##
## [param dots] - The array of dots that can be replaced. [br]
## @modifies [param dots] - Removes the dots that was replaced.
func addQuestionDot(dots: Array):
	var currDot = dots.pick_random();
	var questionDot = replaceDot(questionDot, currDot);

func _ready():
	setupDots()
	call_deferred("setupAnswerDots")

##If the answer dot eaten is the right answer, it resets the dots. If 3 correct answers in a row are eaten, it gives a power pellet.
func on_answer_dot_eaten(isAnswer):
	if (isAnswer):
		setupDots()
		correct_answers += 1
		call_deferred("setupAnswerDots")
		if (correct_answers >= 3):
			call_deferred("addPowerPellet")
			correct_answers = 0
	else:
		correct_answers = 0;
