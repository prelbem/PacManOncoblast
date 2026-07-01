extends Node2D

const file_path = "res://Questions/answers.json"

func _ready():
	get_tree().paused = false
	setupJSON();

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
		
		for j in falseAnswersJson.size():
			var answer = falseAnswersJson[j]["options"]["title"];
			if (answer != trueAnswer):
				falseAnswers.append(answer);
	
		Global.add_question(question, trueAnswer, falseAnswers);

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_level.tscn")


func _on_settings_button_pressed() -> void:
	print_debug("settings")
	get_tree().change_scene_to_file("res://settings.tscn")
