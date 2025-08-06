extends Button
class_name ButtonCustom

@export var audioPlayer: AudioPlayerCustom = null

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	if audioPlayer != null:
		audioPlayer.play_sound(Sounds.UI_BUTTON_CLICK, "SFX")
