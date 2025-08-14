extends Area2D
var isAnswer = true
@export var text = "HI"

func changeAnswer(answer):
	$CenterContainer/Answer.text = answer
