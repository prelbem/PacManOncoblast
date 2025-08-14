extends TileMapLayer
@onready var dot = preload("res://Level Assets/dot.tscn");
@onready var answerDot = preload("res://Level Assets/AnswerDot.tscn")
@onready var player = get_tree().get_first_node_in_group("Player")

func setupDots():
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
	var cells = get_used_cells()
	for i in range(cells.size()):
		var cell = cells[i]
		var dotChild = dot.instantiate()
		call_deferred("add_child", dotChild)
		#add_child(dotChild)
		dotChild.global_position = cell * tile_set.tile_size + Vector2i(16, 16);
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
func _ready():
	randomize()
	setupDots()
	#setupAnswerDots()
	call_deferred("setupAnswerDots")
	player.connect("answer_dot_eaten", on_answer_dot_eaten)

func on_answer_dot_eaten(isAnswer):
	if (isAnswer):
		setupDots()
		call_deferred("setupAnswerDots")
