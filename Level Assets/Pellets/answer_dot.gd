extends Area2D
var isAnswer = true

func changeAnswer(answer):
	$CenterContainer/Answer.text = answer

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if isAnswer:
			get_parent().player.updateScore(10)
			get_parent().on_answer_dot_eaten(isAnswer)
		else:
			get_parent().player.updateScore(-5)
		queue_free()
