extends Control
var ticks = 4
func _ready():
	get_tree().paused = true
	

func _on_timer_timeout() -> void:
	ticks -= 1
	$AddPeriod.stop()
	$AddPeriod.start()
	var time_left = $Timer.time_left
	if ticks == 1:
		$Label.text = "Go!"
	else:
		$Label.text = str(int(ticks) - 1)
	
	
	if (ticks == 0):
		get_tree().paused = false
		queue_free()


func _on_add_period_timeout() -> void:
	if $Label.text != "Go!":
		$Label.text += "."
