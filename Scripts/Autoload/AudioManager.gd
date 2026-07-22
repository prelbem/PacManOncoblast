extends AudioStreamPlayer

const DIRECTORY = "res://Music/"
const _MUSIC: Dictionary = {
	Music.MAIN_LEVEL: "mainMusic.mp3"
}

enum Music {
	MAIN_LEVEL
}

func play_music(music: Music):
	get_node("Music").stream = load(DIRECTORY + _MUSIC[music])
	get_node("Music").play();
