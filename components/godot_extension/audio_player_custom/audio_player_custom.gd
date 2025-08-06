@icon("res://assets/images/icons/editor/AudioStreamPlayer2D.svg")
extends Node2D
class_name AudioPlayerCustom

var _audioPlayers: Array[AudioStreamPlayer] = []

func play_sound(sound: AudioStream, playerOwner=self, pitch=1.0, bus="Master") -> void:
	if playerOwner == null:
		playerOwner = get_tree().current_scene # Some nodes give the tree root, which could be null

	var selectedPlayer: AudioStreamPlayer = null
	for player: AudioStreamPlayer in _audioPlayers:
		if !player.playing:
			selectedPlayer = player

	if selectedPlayer == null:
		var newPlayer: AudioStreamPlayer = AudioController.get_player(playerOwner)
		while !is_instance_valid(newPlayer):
			newPlayer = AudioController.get_player(playerOwner)

		_audioPlayers.append(newPlayer)
		selectedPlayer = newPlayer

	if selectedPlayer.get_parent() == null:
		playerOwner.add_child(selectedPlayer)

	selectedPlayer.stream = sound
	selectedPlayer.bus = bus
	selectedPlayer.pitch_scale = pitch
	selectedPlayer.play()

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		for player in _audioPlayers:
			if player == null:
				continue
			
			AudioController.return_player(player)
				
