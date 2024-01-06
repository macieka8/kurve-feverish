extends Node2D
class_name Game

signal game_ended

var player_scene := preload("res://scenes/player.tscn")

var game_state := GameState.PAUSED

var players: Array[PlayerData]
var ended: bool

func _ready() -> void:
	for player_data in players:
		var player_instance := player_scene.instantiate() as Player
		player_instance.player_data = player_data
		player_instance.position = Vector2(randi_range(-300, 300), randi_range(-300, 300))
		player_instance.rotation = randf_range(0, TAU)
		player_instance.add_to_group("player")
		player_instance.add_to_group("gameplay")
		if game_state == GameState.PAUSED:
			player_instance.process_mode = Node.PROCESS_MODE_DISABLED
		add_child(player_instance)

func _process(delta: float) -> void:
	if game_state == GameState.PLAYING:
		var players := get_tree().get_nodes_in_group("player")
		if players.size() == 0:
			ended = true
			game_ended.emit()

	if Input.is_action_just_pressed("pause"):
		var gameplay_nodes = get_tree().get_nodes_in_group("gameplay")
		var visible_on_pause_nodes = get_tree().get_nodes_in_group("visible_on_pause")
		if game_state == GameState.PAUSED:
			game_state = GameState.PLAYING
		elif game_state == GameState.PLAYING:
			game_state = GameState.PAUSED

		for gameplay_node in gameplay_nodes:
			if game_state == GameState.PAUSED:
				gameplay_node.process_mode = Node.PROCESS_MODE_DISABLED
			elif game_state == GameState.PLAYING:
				gameplay_node.process_mode = Node.PROCESS_MODE_INHERIT

		for visible_on_pause in visible_on_pause_nodes:
			if game_state == GameState.PAUSED:
				visible_on_pause.show()
			elif game_state == GameState.PLAYING:
				visible_on_pause.hide()
