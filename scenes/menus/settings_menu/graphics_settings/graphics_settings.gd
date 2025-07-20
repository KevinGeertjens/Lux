extends MarginContainer

@onready var _windowSizeButton: OptionButton = $HBox/Grid/WindowSizeButton
@onready var _windowModeButton: OptionButton = $HBox/Grid/WindowModeButton
@onready var _monitorButton: OptionButton = $HBox/Grid/MonitorButton
@onready var _vsyncCheckBox: CheckBox = $HBox/Grid/VsyncCheckBox

var _windowModeMap: Dictionary = {}

func _ready() -> void:
	_update_inputs()


#region Button Updates
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

	UiUtils.select_option_by_string(_monitorButton, str(GraphicsSettings.settings["monitor"]))

func _update_vsync_checkbox() -> void:
	_vsyncCheckBox.button_pressed = GraphicsSettings.settings["vsync"]

#endregion
