extends PanelContainer

@onready var playButton = $Margin/VBox/Buttons/PlayButton

const gameplayScene: PackedScene = preload("res://scenes/gameplay/gameplay.tscn")

func _ready() -> void:
	playButton.grab_focus()

func _on_play_button_pressed() -> void:
	SceneManager.change_scene(gameplayScene)

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
