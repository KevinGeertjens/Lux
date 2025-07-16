extends PanelContainer

@onready var continueButton: Button = $Margin/Panel/Margin/Buttons/ContinueButton

func _on_visibility_changed() -> void:
	if visible && continueButton != null:
		continueButton.grab_focus()

func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_main_menu_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.change_scene(load("res://scenes/menus/main_menu/main_menu.tscn"))

func _on_quit_desktop_button_pressed() -> void:
	get_tree().quit()
