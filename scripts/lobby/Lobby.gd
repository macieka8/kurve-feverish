extends Node
class_name Lobby

signal player_data_changed
signal start_game

var default_player_data: Array[PlayerData] = [
	PlayerData.from("", KEY_Q, KEY_W, "Q", "W"),
	PlayerData.from("", KEY_Z, KEY_X, "Z", "X"),
	PlayerData.from("", KEY_O, KEY_P, "O", "P"),
	PlayerData.from("", KEY_DOWN, KEY_UP, "DOWN", "UP")
]

var names := load_names()
var players: Array[PlayerData]

func _ready() -> void:
	player_data_changed.emit()

func add_player() -> void:
	var new_player: PlayerData = PlayerData.new()
	if players.size() < default_player_data.size():
		new_player = default_player_data[players.size()]
	new_player.name = get_random_name()
	players.append(new_player)
	player_data_changed.emit()
	
func remove_player(player_id: int) -> void:
	players.remove_at(player_id)
	player_data_changed.emit()

func get_random_name() -> String:
	return names[randi_range(0, names.size() - 1)]

# Names source
# https://dane.gov.pl/pl/dataset/1667,lista-imion-wystepujacych-w-rejestrze-pesel-osoby-zyjace/resource/44834/
func load_names() ->  PackedStringArray:
	var file := FileAccess.open("res://names.txt", FileAccess.READ)
	return file.get_csv_line()

func _on_addplayerbutton_pressed() -> void:
	add_player()

func _on_startgame_pressed() -> void:
	if is_ready():
		start_game.emit()

func is_ready() -> bool:
	for player in players:
		if player.left == null:
			return false
		if player.right == null:
			return false
	return true

