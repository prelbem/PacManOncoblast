extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	var text = Global.getInfo()[Global.QUESTION_INDEX];
	var answers: Array = Global.getFalseAnswers()[Global.QUESTION_INDEX].duplicate();
	answers.append(Global.getTrueAnswers()[Global.QUESTION_INDEX]);
	answers.shuffle();
	
	text += "\n\n";
	
	text += Global.getQuestions()[Global.QUESTION_INDEX];
	
	text += "\n";
	for i in answers.size():
		text += "\n" + char(65 + i) + ". " + answers[i]
		if (Global.getTrueAnswers().has(answers[i])):
			Global.TRUE_LETTER = char(65 + i);
		
	get_node("Info").text = text;

func _exit_tree() -> void:
	get_tree().paused = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	queue_free();
