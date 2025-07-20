extends PanelContainer

@onready var settingsMenu: PanelContainer = $SettingsMenu
@onready var playButton = $Margin/VBox/Buttons/PlayButton

func _ready() -> void:
	playButton.grab_focus()

func _on_settings_menu_visibility_changed() -> void:
	if playButton != null:
		playButton.grab_focus()


func _on_play_button_pressed() -> void:
	SceneManager.change_scene(load("res://scenes/gameplay/gameplay.tscn"))

func _on_settings_button_pressed() -> void:
	settingsMenu.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
