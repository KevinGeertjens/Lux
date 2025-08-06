extends TabContainer
class_name TabContainerCustom

@export var audioPlayer: AudioPlayerCustom = null

func _ready() -> void:
	tab_selected.connect(_on_tab_selected)

func _on_tab_selected(_tab: int) -> void:
	if audioPlayer != null:
		audioPlayer.play_sound(Sounds.UI_BUTTON_CLICK, "SFX")

