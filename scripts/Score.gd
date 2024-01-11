extends Node
class_name Score

signal max_score_reached
signal score_update()
signal score_ready

var scores: Array[int]
var max_score: int

var dead_players_count := 0

func setup_score(size: int, game: Game) -> void:
	scores.resize(size)
	max_score = (size - 1) * 5
	game.player_death.connect(_on_player_death)
	game.round_ended.connect(_on_round_ended)
	score_ready.emit()

func _on_player_death(player_id: int):
	scores[player_id] += dead_players_count
	dead_players_count += 1
	score_update.emit()

func _on_round_ended():
	dead_players_count = 0
	for score in scores:
		if score >= max_score:
			max_score_reached.emit()
