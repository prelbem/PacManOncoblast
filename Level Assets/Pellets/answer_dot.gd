extends Area2D
var isAnswer = true

func changeAnswer(answer):
	$CenterContainer/Answer.text = answer

##Gives the player score if it's the correct answer, or takes away points if it's wrong.
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if isAnswer:
			get_parent().playerManager.updateScore(10)
			get_parent().on_answer_dot_eaten(isAnswer)
		else:
			get_parent().playerManager.updateScore(-5)
		queue_free()
