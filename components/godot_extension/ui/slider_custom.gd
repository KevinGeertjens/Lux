extends HSlider
class_name HSliderCustom

@export var audioPlayer: AudioPlayerCustom = null
var _timer: Timer = Timer.new()
var _playSound: bool = false

func _ready() -> void:
	_timer.one_shot = true
	add_child(_timer)
	drag_started.connect(_on_drag_started)
	drag_ended.connect(_on_drag_ended)
	value_changed.connect(_on_value_changed)

func _process(_delta: float) -> void:
	if _playSound && _timer.time_left <= 0 && audioPlayer != null:
		audioPlayer.play_sound(Sounds.UI_BUTTON_CLICK, "SFX")
		_timer.start(0.5)

func _on_drag_started() -> void:
	_playSound = true

func _on_drag_ended(_value_changed: bool) -> void:
	_playSound = false

func _on_value_changed(_value: float) -> void:
	if !_playSound && _timer.time_left <= 0 && audioPlayer != null:
		audioPlayer.play_sound(Sounds.UI_BUTTON_CLICK, "SFX")
		_timer.start(0.5)

