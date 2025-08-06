extends PanelContainer

@onready var settingsMenu: PanelContainer = $SettingsMenu
@onready var continueButton: Button = $Margin/Panel/Margin/Buttons/ContinueButton

func _on_visibility_changed() -> void:
	if visible:
		continueButton.grab_focus()

func _on_settings_menu_visibility_changed() -> void:
	if visible:
		continueButton.grab_focus()


func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_settings_button_pressed() -> void:
	settingsMenu.show()

func _on_quit_main_menu_button_pressed() -> void:
	get_tree().paused = false
	FadeSceneTransition.fade_to("res://scenes/menus/main_menu/main_menu.tscn")

func _on_quit_desktop_button_pressed() -> void:
	get_tree().quit()

