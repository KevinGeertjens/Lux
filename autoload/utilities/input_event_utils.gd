extends Node

#region Serializers
func serialize_input_event(event: InputEvent) -> Dictionary:
	if event is InputEventKey:
		return serialize_input_event_key(event)
	if event is InputEventMouseButton:
		return serialize_input_event_mouse_button(event)
	if event is InputEventJoypadButton:
		return serialize_input_event_joypad_button(event)
	if event is InputEventJoypadMotion:
		return serialize_input_event_joypad_motion(event)

	push_error("Failed serializing InputEvent: Type not supported")
	return {}

func serialize_input_event_key(event: InputEventKey) -> Dictionary:
	var dict: Dictionary = {}
	dict["type"] = "InputEventKey"
	
	dict["keycode"] = event.keycode
	if dict["keycode"] == 0:
		dict["keycode"] = event.physical_keycode

	dict["location"] = event.location
	return dict

func serialize_input_event_mouse_button(event: InputEventMouseButton) -> Dictionary:
	var dict: Dictionary = {}
	dict["type"] = "InputEventMouseButton"
	dict["buttonIndex"] = event.button_index
	return dict

func serialize_input_event_joypad_button(event: InputEventJoypadButton) -> Dictionary:
	var dict: Dictionary = {}
	dict["type"] = "InputEventJoypadButton"
	dict["buttonIndex"] = event.button_index
	return dict

func serialize_input_event_joypad_motion(event: InputEventJoypadMotion) -> Dictionary:
	var dict: Dictionary = {}
	dict["type"] = "InputEventJoypadMotion"
	dict["axis"] = event.axis
	dict["axisValue"] = event.axis_value
	return dict

#endregion


#region Deserializers
func deserialize_input_event(eventDict: Dictionary) -> InputEvent:
	if "type" not in eventDict.keys():
		push_error("Failed deserializing InputEvent: Type key not found")
		return null

	if eventDict["type"] == "InputEventKey":
		return deserialize_input_event_key(eventDict)
	if eventDict["type"] == "InputEventMouseButton":
		return deserialize_input_event_mouse_button(eventDict)
	if eventDict["type"] == "InputEventJoypadButton":
		return deserialize_input_event_joypad_button(eventDict)
	if eventDict["type"] == "InputEventJoypadMotion":
		return deserialize_input_event_joypad_motion(eventDict)

	push_error("Failed deserializing InputEvent: Type not supported")
	return null

func deserialize_input_event_key(eventDict: Dictionary) -> InputEventKey:
	if "keycode" not in eventDict.keys() || "location" not in eventDict.keys():
		push_error("Failed to deserialize InputEventKey: missing dictionary values")
		return null

	var event := InputEventKey.new()
	event.keycode = eventDict["keycode"]
	event.location = eventDict["location"]
	return event

func deserialize_input_event_mouse_button(eventDict: Dictionary) -> InputEventMouseButton:
	if "buttonIndex" not in eventDict.keys():
		push_error("Failed to deserialize InputEventMouseButton: missing dictionary values")
		return null

	var event := InputEventMouseButton.new()
	event.button_index = eventDict["buttonIndex"]
	return event

func deserialize_input_event_joypad_button(eventDict: Dictionary) -> InputEventJoypadButton:
	if "buttonIndex" not in eventDict.keys():
		push_error("Failed to deserialize InputEventJoypadButton: missing dictionary values")
		return null

	var event := InputEventJoypadButton.new()
	event.button_index = eventDict["buttonIndex"]
	return event

func deserialize_input_event_joypad_motion(eventDict: Dictionary) -> InputEventJoypadMotion:
	if "axis" not in eventDict.keys() || "axisValue" not in eventDict.keys():
		push_error("Failed to deserialize InputEventJoypadMotion: missing dictionary values")
		return null

	var event := InputEventJoypadMotion.new()
	event.axis = eventDict["axis"]
	event.axis_value = eventDict["axisValue"]
	return event

#endregion