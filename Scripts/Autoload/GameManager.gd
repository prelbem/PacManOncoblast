extends Node

const DIRECTORY = "res://Levels/";
const _SCENE_PATHS: Dictionary = {
	Scenes.MAIN_LEVEL: "MainLevel.tscn",
	Scenes.SETTINGS: "Settings.tscn",
	Scenes.TITLE_SCREEN: "TitleScreen.tscn",
	Scenes.GAME_OVER: "GameOver.tscn"
}
enum Scenes {
	MAIN_LEVEL, SETTINGS, TITLE_SCREEN, GAME_OVER
}

func change_scene(scene: Scenes):
	var path = _SCENE_PATHS.get(scene, _SCENE_PATHS[Scenes.TITLE_SCREEN])
	get_tree().change_scene_to_file(DIRECTORY + path)

func freeze_frame(time = 1):
	get_tree().paused = true
	await get_tree().create_timer(time, true).timeout
	get_tree().paused = false
