extends BaseSettings

const DEFAULT_PATH = "user://default_controls_settings.json"

func _ready() -> void:
	PATH = "user://controls_settings.json"
	_save(DEFAULT_PATH) # Save default project settings before loading actual settings

	_load()
	_save()

func _load(path: String = PATH) -> void:
	var inputMap: Dictionary = JsonFileUtils.load_dict(path)
	if !inputMap:
		return # Game will use default input map as defined in the project

	for action in inputMap.keys():
		if InputMap.has_action(action):
			InputMap.action_erase_events(action)
		else:
			InputMap.add_action(action)

		for eventDict: Dictionary in inputMap[action]:
			var event := InputEventUtils.deserialize_input_event(eventDict)
			InputMap.action_add_event(action, event)

func _save(path: String = PATH) -> void:
	var inputMap: Dictionary = {}

	for action: String in InputMap.get_actions():
		var events: Array = []
		for event: InputEvent in InputMap.action_get_events(action):
			events.append(InputEventUtils.serialize_input_event(event))
		inputMap[action] = events
	
	JsonFileUtils.save_dict(inputMap, path)

func set_action_event(action: String, event: InputEvent) -> void:
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	_save()

func set_default_settings() -> void:
	_load(DEFAULT_PATH)
	_save()
