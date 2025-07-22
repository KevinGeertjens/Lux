extends Control

@export var nextScene: PackedScene
@export var startTime: float = 0.5
@export var fadeInTime: float = 1.0
@export var pauseTime: float = 1.5
@export var fadeOutTime: float = 1.0
@export var endTime: float = 0.5

@onready var splashScreenContainer: CenterContainer = $SplashScreenContainer

var _splashScreens: Array

func _ready() -> void:
	_get_screens()
	_fade()

func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		SceneManager.change_scene(nextScene)

func _get_screens() -> void:
	_splashScreens = splashScreenContainer.get_children()
	for screen: TextureRect in _splashScreens:
		screen.modulate.a = 0.0

func _fade() -> void:
	for screen: TextureRect in _splashScreens:
		var tween := create_tween()
		tween.tween_interval(startTime)
		tween.tween_property(screen, "modulate:a", 1.0, fadeInTime)
		tween.tween_interval(pauseTime)
		tween.tween_property(screen, "modulate:a", 0.0, fadeOutTime)
		tween.tween_interval(endTime)
		await tween.finished

	SceneManager.change_scene(nextScene)
