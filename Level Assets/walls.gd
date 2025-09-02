extends TileMapLayer
@onready var dot = preload("res://Level Assets/dot.tscn");
@onready var answerDot = preload("res://Level Assets/AnswerDot.tscn")
@onready var powerPellet = preload("res://Level Assets/power_pellet.tscn")
@onready var player = %Player
var correct_answers = 0

func setupDots():
	for child in get_children():
		if (!child.is_in_group("Power Pellet")):
			call_deferred("remove_child", child)
			#remove_child(child)
			child.queue_free()
		
	var cells = get_used_cells()
	for i in range(cells.size()):
		var cell = cells[i]
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
	var created = []
	var question = Global.questions[questionIndex]
	%HUD.get_node("Question").text = question
	var trueAnswers = Global.trueAnswers[questionIndex]
	var numDots = trueAnswers.size()
	
	for i in numDots:
		var currDot = dots[randi() % dots.size()];
		var dotIsInvalid = true
		#get a dot that's far away from the player and also isn't an existing answer dot
		while dotIsInvalid:
			currDot = dots[randi() % dots.size()];
			dotIsInvalid = false
			if currDot.global_position.distance_to(player.global_position) <= 64:
				dotIsInvalid = true
			else:
				for checkDot in created:
					if checkDot.global_position == currDot.global_position:
						dotIsInvalid = true
						break;
		
		var answer = answerDot.instantiate()
		add_child(answer)
		answer.global_position = currDot.global_position
		answer.changeAnswer(trueAnswers[i])
		answer.add_to_group("Answer Dots")
		created.push_front(answer)
		
		remove_child(currDot)
		currDot.queue_free()
	var falseAnswers = Global.falseAnswers[questionIndex]
	numDots = falseAnswers.size()
	for i in numDots:
		var currDot = dots[randi() % dots.size()];
		var dotIsInvalid = true
		#get a dot that's far away from the player and also isn't an existing answer dot
		while dotIsInvalid:
			currDot = dots[randi() % dots.size()];
			dotIsInvalid = false
			if currDot.global_position.distance_to(player.global_position) <= 64:
				dotIsInvalid = true
			else:
				for checkDot in created:
					if checkDot.global_position == currDot.global_position:
						dotIsInvalid = true
						break;
		
		var answer = answerDot.instantiate()
		add_child(answer)
		answer.global_position = currDot.global_position
		answer.changeAnswer(falseAnswers[i])
		answer.isAnswer = false
		answer.add_to_group("Answer Dots")
		created.push_front(answer)
		
		remove_child(currDot)
		currDot.queue_free()


func addPowerPellet():
	var dots = get_children()
	var currDot = dots[randi() % dots.size()];
	var currPellet = powerPellet.instantiate()
	currPellet.global_position = currDot.global_position
	add_child(currPellet)
	currPellet.add_to_group("Power Pellets")
	currDot.queue_free()
	
func _ready():
	randomize()
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
