extends Node2D

func _ready():
	Global.loaded.connect(setupDone)

func setupDone():
	GameManager.change_scene(GameManager.Scenes.TITLE_SCREEN)
