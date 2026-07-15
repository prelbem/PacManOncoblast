extends Panel

func _ready():
	Global.loaded.connect(setupDone)
	Global.loading.connect(loading)

func setupDone():
	GameManager.change_scene(GameManager.Scenes.TITLE_SCREEN)

func loading(i: int):
	print(i)
