extends CanvasLayer

@onready var pauseMenu: PanelContainer = $PauseMenu

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_game_menu"):
        get_tree().paused = true
        pauseMenu.show()