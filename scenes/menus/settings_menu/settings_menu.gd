extends PanelContainer

@onready var tabs: TabContainer = $Margin/Panel/Margin/VBox/Tabs
@onready var graphics: MarginContainer = $Margin/Panel/Margin/VBox/Tabs/Graphics
@onready var controls: MarginContainer = $Margin/Panel/Margin/VBox/Tabs/Controls

func _process(_delta: float) -> void:
	if visible && controls.inputDebounce <= 0 && Input.is_action_just_pressed("ui_cancel"):
		hide()

func _on_visibility_changed() -> void:
	if visible:
		call_deferred("_focus_first_tab") # call_deferred to wait for tab buttons to initialize

func _focus_first_tab() -> void:
	var tabBar: TabBar = tabs.get_tab_bar()
	if tabBar:
		tabBar.grab_focus()

func _on_exit_button_pressed() -> void:
	hide()
