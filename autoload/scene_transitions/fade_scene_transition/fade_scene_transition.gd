extends CanvasLayer

@onready var _animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var _colorRect: ColorRect = $ColorRect

@export var pauseTime: float = 0.1
var _timer: Timer = Timer.new()

func _ready() -> void:
	_colorRect.color.a = 0

	_timer.timeout.connect(fade_in)
	_timer.one_shot = true
	add_child(_timer)

func fade_to(scenePath: String) -> void:
	var scene: PackedScene = load(scenePath)
	fade_to_direct(scene)

func fade_to_direct(scene: PackedScene) -> void:
	_animationPlayer.play("FadeIn")
	await _animationPlayer.animation_finished
	
	SceneManager.change_scene(scene)
	_timer.start(pauseTime)

func fade_in() -> void:
	_timer.stop()
	_animationPlayer.play("FadeOut")
	await _animationPlayer.animation_finished
