extends Area2D
var isAnswer = true
@export var text = "HI"

func changeAnswer(answer):
	$CenterContainer/Answer.text = answer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if isAnswer:
			get_parent().player.updateScore(10)
			get_parent().on_answer_dot_eaten(isAnswer)
		else:
			get_parent().player.updateScore(-5)
		queue_free()
