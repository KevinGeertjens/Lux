extends MarginContainer

const LABEL_WIDTH = 175
const SECTION_ACTIONS: Dictionary = {
	"Movement": {
		"move_up": "Move Up",
		"move_left": "Move Left",
		"move_down": "Move Down",
		"move_right": "Move Right",
	},
	"Other": {
		"ui_game_menu": "Pause Game",
	}
}

@onready var _keybindSections = $HBox/Scroll/Margin/KeybindSections
@onready var _audioPlayer = $AudioPlayer

var _section_nodes: Dictionary = {}
var _awaitingInput: bool = false
var _selectedButton: Button
var inputDebounce: int = 0

func _ready() -> void:
	var header1Settings := load("res://resources/ui/label_settings/header_1.tres")

	for section: String in SECTION_ACTIONS.keys():
		var node := VBoxContainer.new()

		var header := Label.new()
		header.text = section
		header.label_settings = header1Settings
		node.add_child(header)

		var grid := GridContainer.new()
		grid.name = "Grid"
		grid.columns = 2
		grid.add_theme_constant_override("h_separation", 24)
		grid.add_theme_constant_override("v_separation", 12)
		node.add_child(grid)

		_section_nodes[section] = node

		for action: String in SECTION_ACTIONS[section]:
			_section_add_action_button(section, action)

		_keybindSections.add_child(node)
	
	_update_action_buttons()

func _process(_delta: float) -> void:
	if inputDebounce > 0:
		inputDebounce -= 1

func _input(event: InputEvent) -> void:
	if !_awaitingInput:
		return

	var action: String = _selectedButton.name
	if event is not InputEventMouseMotion:
		if event is InputEventMouseButton:
			event.double_click = false

		ControlsSettings.set_action_event(action, event)
		for section: String in SECTION_ACTIONS.keys():
			for otherAction: String in SECTION_ACTIONS[section]:
				if otherAction != action:
					InputMap.action_erase_event(otherAction, event)

		inputDebounce = 10
		_selectedButton.text = event.as_text()
		_awaitingInput = false
		_update_action_buttons()

func _section_add_action_button(section: String, action: String) -> void:
	var node: VBoxContainer = _section_nodes[section]
	var grid = node.get_node("Grid")
	if !node || !grid:
		return

	var label: Label = Label.new()
	label.text = SECTION_ACTIONS[section][action]
	label.custom_minimum_size.x = LABEL_WIDTH
	grid.add_child(label)

	var button = ButtonCustom.new()
	button.audioPlayer = _audioPlayer
	button.name = action
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.connect("pressed", _on_action_button_pressed.bind(button))

	grid.add_child(button)

func _update_action_buttons():
	for section: String in SECTION_ACTIONS.keys():
		var node: VBoxContainer = _section_nodes[section]
		var grid: GridContainer = node.get_node("Grid")

		for action: String in SECTION_ACTIONS[section]:
			var button: Button = grid.get_node(action)
			button.text = ""

			var inputEvents: Array = InputMap.action_get_events(action)
			if len(inputEvents) > 0:
				var inputEvent: InputEvent = inputEvents[0]
				button.text = inputEvent.as_text()


func _on_action_button_pressed(button: Button) -> void:
	if inputDebounce <= 0:
		button.text = "..."
		_awaitingInput = true
		_selectedButton = button

func _on_default_button_pressed() -> void:
	ControlsSettings.set_default_settings()
	_update_action_buttons()
