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
		"ui_game_menu": "Pause Game"
	}
}

@onready var _keybindSections = $HBox/Scroll/KeybindSections

var _section_nodes: Dictionary = {}

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

func _section_add_action_button(section: String, action: String) -> void:
	var node: VBoxContainer = _section_nodes[section]
	var grid = node.get_node("Grid")
	if !node || !grid:
		return

	var label: Label = Label.new()
	label.text = SECTION_ACTIONS[section][action]
	label.custom_minimum_size.x = LABEL_WIDTH
	grid.add_child(label)

	var inputAction: InputEvent = InputMap.action_get_events(action)[0]
	var button = Button.new()
	button.text = inputAction.as_text()
	grid.add_child(button)
	

func _on_default_button_pressed() -> void:
	pass
