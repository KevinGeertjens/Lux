extends BaseSettings

enum WINDOW_MODE {FULLSCREEN, BORDERLESS_WINDOW, WINDOWED}
const WINDOW_SIZE: Array = ["1280x720", "1920x1080", "2560x1440", "3840x2160"]

func _ready() -> void:
	PATH = "user://graphics_settings.json"
	DEFAULT_SETTINGS = {
		"windowSize" : "1920x1080",
		"windowMode": WINDOW_MODE.FULLSCREEN,
		"monitor": 0,
		"vsync" : true,
	}

	_load()
	_save()
	_apply()

func _apply() -> void:
	set_window_size(settings["windowSize"])
	set_window_mode(settings["windowMode"])
	set_monitor(settings["monitor"])
	set_vsync(settings["vsync"])


#region: Setters
func set_window_size(windowSize: String) -> void:
	if WINDOW_SIZE.find(windowSize) < 0:
		push_error("Could not set window size: windowSize not in WINDOW_SIZES")
		return

	var split: Array = windowSize.split("x")
	if len(split) != 2:
		push_error("Could not set window size: windowSize expected 2 values, but %s were given" % len(split))
		return

	var width := int(split[0])
	var height := int(split[1])
	var vector := Vector2i(width, height)

	get_window().size = vector
	settings["windowSize"] = windowSize
	_save()

	var offset: Vector2 = (DisplayServer.screen_get_size() - DisplayServer.window_get_size()) / 2
	DisplayServer.window_set_position(offset)
	set_monitor(settings["monitor"])

func set_window_mode(windowMode: WINDOW_MODE) -> void:
	var mode: Window.Mode
	var borderlessWindow: bool

	match int(windowMode):
		WINDOW_MODE.FULLSCREEN:	
			mode = Window.MODE_FULLSCREEN
			borderlessWindow = false
		WINDOW_MODE.BORDERLESS_WINDOW:
			mode = Window.MODE_WINDOWED
			borderlessWindow = true
		WINDOW_MODE.WINDOWED:
			mode = Window.MODE_WINDOWED
			borderlessWindow = false

	var window: Window = get_window()
	window.set_mode(mode)
	window.borderless = borderlessWindow

	settings["windowMode"] = windowMode
	_save()

	set_window_size(settings['windowSize'])
	
func set_monitor(monitorIndex: int) -> void:
	var screenCount: int = DisplayServer.get_screen_count()
	if monitorIndex > screenCount:
		push_error("Could not set monitor: monitorIndex was %s, while there are only %s monitors available" % monitorIndex, screenCount)

	DisplayServer.window_set_current_screen(monitorIndex)
	settings["monitor"] = monitorIndex
	_save()

func set_vsync(vsyncEnabled: bool) -> void:
	var map = {
		false: DisplayServer.VSYNC_DISABLED,
		true: DisplayServer.VSYNC_ENABLED
	}

	var vsyncMode: int = map[vsyncEnabled]
	DisplayServer.window_set_vsync_mode(vsyncMode)
	settings["vsync"] = vsyncEnabled
	_save()

#endregion
