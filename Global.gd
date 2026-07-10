extends Node
var _QUESTIONS: Array[String] = []
var _TRUE_ANSWERS: Array[String] = []
var _FALSE_ANSWERS: Array[Array] = []
var _INFO: Array[String] = []

var TRUE_LETTER = "A"
var QUESTION_INDEX = 0;
var ANSWER_SET: Array[String] = []
var VISIBLE_JOYSTICK = true

const file_path = "res://Questions/answers.json"

func _ready() -> void:
	setupJSON()

func setupJSON(): 
	var file = FileAccess.open(file_path, FileAccess.READ);
	var json = file.get_as_text()
	var content = JSON.parse_string(json);
	var questions: Array = content["list"]
	
	for i in 3:
		var question_json = questions[i];
		var question = question_json["title"];
		var trueAnswer = question_json["question_answer"][0]["options"]["title"];
		var falseAnswersJson: Array = question_json["question_option"];
		var falseAnswers: Array[String] = [];
		
		var info = question_json["story"][0]["original"] + " " + question_json["info"]
		
		for j in falseAnswersJson.size():
			var answer = falseAnswersJson[j]["options"]["title"];
			if (answer != trueAnswer):
				falseAnswers.append(answer);
	
		add_question(question, info, trueAnswer, falseAnswers);

func add_question(question: String, info: String, trueAnswer: String, falseAnswersAdd: Array[String]):
	_QUESTIONS.append(question);
	_INFO.append(info)
	_TRUE_ANSWERS.append(trueAnswer);
	_FALSE_ANSWERS.append(falseAnswersAdd);

func getQuestions() -> Array[String]:
	return _QUESTIONS.duplicate();
	
func getTrueAnswers() -> Array[String]:
	return _TRUE_ANSWERS.duplicate();
	
func getFalseAnswers() -> Array[Array]:
	return _FALSE_ANSWERS.duplicate_deep();
	
func getInfo() -> Array[String]:
	return _INFO.duplicate();

func getQuestionsSize() -> int:
	return _QUESTIONS.size();
