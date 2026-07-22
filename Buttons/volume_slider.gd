extends HSlider

@export var bus_name: String
@export var stream: AudioStream

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value = AudioServer.get_bus_volume_linear(bus_index)
	$AudioStreamPlayer.bus = bus_name
	$AudioStreamPlayer.stream = stream

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_drag_started() -> void:
	$AudioStreamPlayer.play()

func _on_drag_ended(value_changed: bool) -> void:
	$AudioStreamPlayer.stop()

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
