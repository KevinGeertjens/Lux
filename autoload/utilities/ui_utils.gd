extends Node

func select_option_by_string(optionButton: OptionButton, value: String) -> void:
	for i in range(optionButton.item_count):
		if optionButton.get_item_text(i) == value:
			optionButton.select(i)
			break