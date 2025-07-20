extends PanelContainer

@onready var tabs: TabContainer = $Margin/Panel/Margin/VBox/Tabs
@onready var graphics: MarginContainer = $Margin/Panel/Margin/VBox/Tabs/Graphics

func _process(_delta: float) -> void:
	if visible && Input.is_action_just_pressed("ui_cancel"):
		hide()

func _on_visibility_changed() -> void:
	if visible:
		call_deferred("_focus_first_tab")

func _focus_first_tab() -> void:
	var tabBar: TabBar = tabs.get_tab_bar()
	if tabBar:
		tabBar.grab_focus()

func _on_exit_button_pressed() -> void:
	hide()
