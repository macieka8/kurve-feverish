extends Node2D
class_name Game

signal game_ended

var player_scene := preload("res://scenes/player.tscn")

var players: Array[PlayerData]
var ended: bool

func _ready() -> void:
	for player_data in players:
		var player_instance := player_scene.instantiate() as Player
		player_instance.player_data = player_data
		player_instance.position = Vector2(randi_range(-300, 300), randi_range(-300, 300))
		player_instance.rotation = randf_range(0, TAU)
		player_instance.add_to_group("player")
		add_child(player_instance)

func _process(delta: float) -> void:
	if !ended:
		var players := get_tree().get_nodes_in_group("player")
		if players.size() == 0:
			ended = true
			game_ended.emit()
