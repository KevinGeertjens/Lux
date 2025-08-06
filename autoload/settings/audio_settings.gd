extends BaseSettings

func _ready() -> void:
	PATH = "user://audio_settings.json"
	DEFAULT_SETTINGS = {
		"Master" : 100,
		"Music": 100,
		"SFX": 100,
	}

	_load()
	_save()
	_apply()

func _apply() -> void:
	set_bus_volume("Master", settings["Master"])
	set_bus_volume("Music", settings["Music"])
	set_bus_volume("SFX", settings["SFX"])

func set_bus_volume(bus: String, volume: float) -> void:
	var index: int = AudioServer.get_bus_index(bus)
	if index == -1:
		push_error("Failed to set bus volume. Could not find bus %s" % bus)
		return

	AudioServer.set_bus_volume_linear(index, volume / 100.0)
	settings[bus] = volume
	_save()
