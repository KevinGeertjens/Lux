extends Node
class_name BaseSettings

var DEFAULT_SETTINGS: Dictionary = {}
var PATH: String = ""

var _settings: Dictionary

func _ready() -> void:
	_load()
	_save()

func _load() -> void:
	var loadedSettings: Dictionary = JsonFile.load_dict(PATH)
	if loadedSettings:
		_settings = loadedSettings
	else:
		_settings = DEFAULT_SETTINGS

func _save() -> void:
	JsonFile.save_dict(_settings, PATH)