extends Node

func get_enum_map(enumToMap: Dictionary) -> Dictionary:
	var map: Dictionary = {}

	for value: int in enumToMap.values():
		var valueName: String = enumToMap.keys()[value]
		var splitName: Array = valueName.to_lower().split("_")
		splitName = splitName.map(func(word): return word.capitalize())
		map[value] = " ".join(splitName)

	return map
