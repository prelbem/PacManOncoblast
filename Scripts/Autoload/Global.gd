extends Node

signal loaded

var _QUESTIONS: Array[String] = []
var _TRUE_ANSWERS: Array[String] = []
var _FALSE_ANSWERS: Array[Array] = []
var _INFO: Array[String] = []

var TRUE_LETTER = "A"
var QUESTION_INDEX = 0;
var ANSWER_SET: Array[String] = []
var VISIBLE_JOYSTICK = true

const file_path = "res://Questions/answers.json"

var httpRequest: HTTPRequest
var thread: Thread

func _ready() -> void:
	httpRequest = HTTPRequest.new();
	add_child(httpRequest)
	httpRequest.request_completed.connect(_on_request_completed)
	
	var error = httpRequest.request("https://api.github.com/repos/godotengine/godot/releases/latest")
	if error != OK:
		push_error("Failed to request data. Error: " + str(error))
	
	await httpRequest.request_completed
	
	setupJSON()
	loaded.emit()

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json["name"])

func setupJSON(): 
	var file = FileAccess.open(file_path, FileAccess.READ);
	var json = file.get_as_text()
	var content = JSON.parse_string(json);
	var questions: Array = content["list"]
	
	for i in questions.size():
		var question_json = questions[i];
		var question = question_json["title"];
		if question_json["isActive"]:
			var trueAnswer = question_json["question_answer"][0]["options"]["title"];
			var falseAnswersJson: Array = question_json["question_option"];
			var falseAnswers: Array[String] = [];
			
			var info: String = "";
			if question_json["story"].size() > 0:
				info = question_json["story"][0]["original"] + " " 
			
			info += question_json["info"]
			
			for j in falseAnswersJson.size():
				var options = falseAnswersJson[j]["options"];
				if options["isActive"]:
					var answer = options["title"];
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
