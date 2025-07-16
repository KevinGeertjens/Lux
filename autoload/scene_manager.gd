extends Node

func change_scene(newScene: Resource) -> void:
	var root: Window = get_tree().get_root()
	var currentScene: Node = get_tree().current_scene
	
	root.remove_child(currentScene)
	currentScene.call_deferred("free") # Frees scene from memory
	
	var newSceneInstance: Node = newScene.instantiate()
	root.add_child(newSceneInstance)
	get_tree().current_scene = newSceneInstance