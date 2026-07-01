extends Node
var questions: Array[String] = [
]

var trueAnswers: Array[String] = [
]

var falseAnswers: Array[Array] = [
]

var visible_joystick = true

func add_question(question: String, trueAnswer: String, falseAnswersAdd: Array[String]):
	questions.append(question);
	trueAnswers.append(trueAnswer);
	falseAnswers.append(falseAnswersAdd);
	
