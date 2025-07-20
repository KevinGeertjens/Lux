extends MarginContainer

@onready var _windowSizeButton: OptionButton = $HBox/Grid/WindowSizeButton
@onready var _windowModeButton: OptionButton = $HBox/Grid/WindowModeButton
@onready var _monitorButton: OptionButton = $HBox/Grid/MonitorButton
@onready var _vsyncCheckBox: CheckBox = $HBox/Grid/VsyncCheckBox

var _windowModeMap: Dictionary = {}

func _ready() -> void:
	_update_inputs()


#region Input Updates
func _update_inputs() -> void:
	_update_window_size_button()
	_update_window_mode_button()
	_update_monitor_button()
	_update_vsync_checkbox()

func _update_window_size_button() -> void:
	_windowSizeButton.clear()
	for windowSize: String in GraphicsSettings.WINDOW_SIZE:
		_windowSizeButton.add_item(windowSize)

	UiUtils.select_option_by_string(_windowSizeButton, GraphicsSettings.settings["windowSize"])

func _update_window_mode_button() -> void:
	_windowModeMap = EnumUtils.get_enum_map(GraphicsSettings.WINDOW_MODE)

	_windowModeButton.clear()
	for windowMode: String in _windowModeMap.values():
		_windowModeButton.add_item(windowMode)

	var itemText: String = _windowModeMap[GraphicsSettings.settings["windowMode"]]
	UiUtils.select_option_by_string(_windowModeButton, itemText)

func _update_monitor_button() -> void:
	_monitorButton.clear()
	for i in range(DisplayServer.get_screen_count()):
		_monitorButton.add_item(str(i + 1))

	UiUtils.select_option_by_string(_monitorButton, str(GraphicsSettings.settings["monitor"] + 1))

func _update_vsync_checkbox() -> void:
	_vsyncCheckBox.button_pressed = GraphicsSettings.settings["vsync"]

#endregion

#region Input Event Handlers
func _on_window_size_button_item_selected(index: int) -> void:
	var windowSize: String = _windowSizeButton.get_item_text(index)
	GraphicsSettings.set_window_size(windowSize)
	_update_inputs()

func _on_window_mode_button_item_selected(index: int) -> void:
	var windowModeText: String = _windowModeButton.get_item_text(index)
	
	var windowMode: int = 0
	for i in _windowModeMap.keys():
		if _windowModeMap[i] == windowModeText:
			windowMode = i
	
	GraphicsSettings.set_window_mode(windowMode)
	_update_inputs()

func _on_monitor_button_item_selected(index: int) -> void:
	var monitor := int(_monitorButton.get_item_text(index)) - 1
	GraphicsSettings.set_monitor(monitor)
	_update_inputs()

func _on_vsync_check_box_toggled(toggled_on: bool) -> void:
	GraphicsSettings.set_vsync(toggled_on)
	_update_inputs()

func _on_default_button_pressed() -> void:
	GraphicsSettings.set_default_settings()
	_update_inputs()

#endregion
