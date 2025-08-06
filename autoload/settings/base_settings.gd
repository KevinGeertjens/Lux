extends Node
class_name BaseSettings

var DEFAULT_SETTINGS: Dictionary = {}
var PATH: String = ""

var settings: Dictionary

func _ready() -> void:
	_load()
	_save()

func _load() -> void:
	var loadedSettings: Dictionary = JsonFileUtils.load_dict(PATH)
	if loadedSettings:
		settings = loadedSettings
	else:
		settings = DEFAULT_SETTINGS.duplicate()

func _save() -> void:
	JsonFileUtils.save_dict(settings, PATH)

func _apply() -> void:
	pass # overwrite in implementations

func set_default_settings() -> void:
	settings = DEFAULT_SETTINGS.duplicate()
	_apply()
	_save()