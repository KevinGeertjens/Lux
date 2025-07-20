extends BaseSettings

enum WINDOW_MODE {FULLSCREEN, BORDERLESS_WINDOW, WINDOWED}
const WINDOW_SIZE: Array = ["1280x720", "1920x1080", "2560x1440", "3840x2160"]

func _ready() -> void:
	_set_constants()
	_load()
	_save()

func _set_constants() -> void:
	PATH = "user://graphics_settings.json"
	DEFAULT_SETTINGS = {
		"windowSize" : Vector2(1920, 1080),
		"windowMode": WINDOW_MODE.FULLSCREEN,
		"monitor": 0,
		"vsync" : true,
	}

func _apply() -> void:
	_set_window_size(_settings["windowSize"])
	_set_window_mode(_settings["windowMode"])
	_set_monitor(_settings["monitor"])
	_set_vsync(_settings["vsync"])


# region: Setters
func _set_window_size(windowSize: String) -> void:
	if WINDOW_SIZE.find(windowSize) == -1:
		push_error("Could not set window size: windowSize not in WINDOW_SIZES")
		return

	var split: Array = windowSize.split("x")
	if len(split) != 2:
		push_error("Could not set window size: windowSize expected 2 values, but %s were given" % len(split))
		return

	var width := int(split[0])
	var height := int(split[1])
	var vector := Vector2(width, height)

	DisplayServer.window_set_size(vector)
	_settings["windowSize"] = vector
	_save()

func _set_window_mode(windowMode: WINDOW_MODE) -> void:
	var mode: int
	var borderlessWindow: bool

	match windowMode:
		WINDOW_MODE.FULLSCREEN:	
			mode = DisplayServer.WINDOW_MODE_FULLSCREEN
			borderlessWindow = false
		WINDOW_MODE.BORDERLESS_WINDOW:
			mode = DisplayServer.WINDOW_MODE_WINDOWED
			borderlessWindow = true
		WINDOW_MODE.WINDOWED:
			mode = DisplayServer.WINDOW_MODE_WINDOWED
			borderlessWindow = false

	DisplayServer.window_set_mode(mode)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderlessWindow)

	_settings["windowMode"] = windowMode
	_save()

	# Optional: if resize and reposition is necessary
	# DisplayServer.window_set_current_screen(_settings["monitor"])
	# _set_window_size(_settings['window_size'])
	
func _set_monitor(monitorIndex: int) -> void:
	var screenCount: int = DisplayServer.get_screen_count()
	if monitorIndex > screenCount:
		push_error("Could not set monitor: monitorIndex was %s, while there are only %s monitors available" % monitorIndex, screenCount)

	DisplayServer.window_set_current_screen(monitorIndex)
	_settings["monitor"] = monitorIndex
	_save()

func _set_vsync(vsyncEnabled: bool) -> void:
	var map = {
		false: DisplayServer.VSYNC_DISABLED,
		true: DisplayServer.VSYNC_ENABLED
	}

	var vsyncMode: int = map[vsyncEnabled]
	DisplayServer.window_set_vsync_mode(vsyncMode)
	_settings["vsync"] = vsyncMode
	_save()

#endregion
