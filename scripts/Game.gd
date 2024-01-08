extends Node2D
class_name Game

signal game_ended
signal round_ended
signal player_death(player_id: int)

var player_scene := preload("res://scenes/player.tscn")
@onready var score: Score = %Score

var game_state := GameState.PAUSED
var players: Array[PlayerData]
var ended: bool

func _ready() -> void:
	score.setup_score(players.size(), self)
	score.max_score_reached.connect(_on_max_score_reached)
	_change_game_state(GameState.PAUSED)
	_create_players()

func _process(delta: float) -> void:
	if game_state == GameState.PLAYING:
		var players := get_tree().get_nodes_in_group("player")
		if players.size() == 0:
			_change_game_state(GameState.PAUSED)
			_create_players()
			_remove_trails()
			round_ended.emit()

	if Input.is_action_just_pressed("pause"):
		if game_state == GameState.PAUSED:
			_change_game_state(GameState.PLAYING)
		elif game_state == GameState.PLAYING:
			_change_game_state(GameState.PAUSED)

func _remove_trails():
	var trails := get_tree().get_nodes_in_group("trail")
	for trail in trails:
		trail.queue_free()

func _create_players():
	var index = 0
	for player_data in players:
		var player_instance := player_scene.instantiate() as Player
		player_instance.player_data = player_data
		player_instance.player_id = index
		player_instance.position = Vector2(randi_range(-300, 300), randi_range(-300, 300))
		player_instance.rotation = randf_range(0, TAU)
		player_instance.on_death.connect(_on_player_death)
		player_instance.add_to_group("player")
		player_instance.add_to_group("gameplay")
		if game_state == GameState.PAUSED:
			player_instance.process_mode = Node.PROCESS_MODE_DISABLED
		add_child(player_instance)
		index += 1

func _change_game_state(new_game_state) -> void:
	game_state = new_game_state
	var gameplay_nodes = get_tree().get_nodes_in_group("gameplay")
	var visible_on_pause_nodes = get_tree().get_nodes_in_group("visible_on_pause")

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

func _on_player_death(player_id: int) -> void:
	player_death.emit(player_id)

func _on_max_score_reached() -> void:
	# prevent game_ended to be emitted twice
	if !ended:
		game_ended.emit()
		ended = true
