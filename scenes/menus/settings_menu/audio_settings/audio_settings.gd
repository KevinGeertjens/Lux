extends MarginContainer

@onready var _masterVolumeSlider = $HBox/Grid/MasterVolumeSlider
@onready var _musicVolumeSlider: HSlider = $HBox/Grid/MusicVolumeSlider
@onready var _sfxVolumeSlider: HSlider = $HBox/Grid/SfxVolumeSlider


func _ready():
	_update_inputs()


#region Input Updates
func _update_inputs() -> void:
	_update_master_volume_slider()
	_update_music_volume_slider()
	_update_sfx_volume_slider()

func _update_master_volume_slider() -> void:
	_masterVolumeSlider.set_value_no_signal(AudioSettings.settings["Master"])

func _update_music_volume_slider() -> void:
	_musicVolumeSlider.set_value_no_signal(AudioSettings.settings["Music"])

func _update_sfx_volume_slider() -> void:
	_sfxVolumeSlider.set_value_no_signal(AudioSettings.settings["SFX"])

#endregion


#region Input Event Handlers
func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioSettings.set_bus_volume("Master", value)
	_update_inputs()

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioSettings.set_bus_volume("Music", value)
	_update_inputs()

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioSettings.set_bus_volume("SFX", value)
	_update_inputs()

func _on_default_button_pressed() -> void:
	AudioSettings.set_default_settings()
	_update_inputs()

#endregion
