extends Node

const BATCH_SIZE: int = 100

var _audioPlayers: Dictionary = {}
var _nInUse: int = 0
var _nTotal: int = 0

func _ready():
	_addToPool(BATCH_SIZE)

func _create_player() -> AudioStreamPlayer:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.process_mode = Node.PROCESS_MODE_ALWAYS
	return player

func _addToPool(amount: int) -> void:
	for i in range(amount):
		var player: AudioStreamPlayer = _create_player()
		_audioPlayers[player] = null

	_nTotal = len(_audioPlayers.keys())

func get_player(ownerEntity: Object) -> AudioStreamPlayer:
	if (_nInUse >= _nTotal):
		_addToPool(BATCH_SIZE)

	for player in _audioPlayers.keys():
		if _audioPlayers[player] == null:
			_audioPlayers[player] = ownerEntity
			_nInUse += 1
			return player

	var player: AudioStreamPlayer = _create_player()
	_audioPlayers[player] = ownerEntity
	_nInUse += 1
	_nTotal += 1
	return player

func return_player(player: AudioStreamPlayer) -> void:
	if player in _audioPlayers.keys():
		_audioPlayers[player] = null
		_nInUse -= 1