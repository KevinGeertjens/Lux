extends OptionButton
class_name OptionButtonCustom

@export var audioPlayer: AudioPlayerCustom = null

func _ready() -> void:
	pressed.connect(_on_pressed)
	item_selected.connect(_on_item_selected)

func _play_sound() -> void:
	if audioPlayer != null:
		audioPlayer.play_sound(Sounds.UI_BUTTON_CLICK, "SFX")
func _on_pressed() -> void:
	_play_sound()

func _on_item_selected(_index: int) -> void:
	_play_sound()
