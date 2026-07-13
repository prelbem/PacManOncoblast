extends Node

const _SCENE_PATHS: Dictionary = {
	Scenes.MAIN_LEVEL: "res://MainLevel.tscn",
	Scenes.SETTINGS: "res://Settings.tscn",
	Scenes.TITLE_SCREEN: "res://TitleScreen.tscn",
	Scenes.GAME_OVER: "res://GameOver.tscn"
}
enum Scenes {
	MAIN_LEVEL, SETTINGS, TITLE_SCREEN, GAME_OVER
}
func change_scene(scene: Scenes):
	var path = _SCENE_PATHS.get(scene, _SCENE_PATHS[Scenes.TITLE_SCREEN])
	get_tree().change_scene_to_file(path)
