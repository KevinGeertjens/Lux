extends Node

func save_dict(dict: Dictionary, path: String) -> void:
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if file:
		var jsonString = JSON.stringify(dict, "\t") # Add "\t" for readability
		file.store_string(jsonString)
		file.close()
	else:
		push_error("Failed to open file for writing dictionary: %s" % path)

func load_dict(path) -> Dictionary:
	if not FileAccess.file_exists(path):
		push_error("Failed to load dict. File does not exist: %s" % path)
		return {}

	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file:
		var jsonString = file.get_as_text()
		return JSON.parse_string(jsonString)
	else:
		push_error("Failed to load dict. Could not open file: %s" % path)
		return {}
	
