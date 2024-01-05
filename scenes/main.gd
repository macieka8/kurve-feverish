extends Node

var lobby_scene := preload("res://scenes/lobby.tscn")
var game_scene := preload("res://scenes/game.tscn")

var lobby: Lobby
var game: Node

func _ready() -> void:
	create_lobby()

func _on_start_game() -> void:
	create_game()
	lobby.queue_free()

func _on_game_ended() -> void:
	create_lobby()
	game.queue_free()

func create_lobby() -> void:
	lobby = lobby_scene.instantiate() as Lobby
	lobby.start_game.connect(_on_start_game)
	add_child(lobby)

func create_game() -> void:
	game = game_scene.instantiate() as Game
	game.players = lobby.players
	game.game_ended.connect(_on_game_ended)
	add_child(game)
