extends Node
class_name Score

signal max_score_reached
signal score_update()

var scores: Array[int]
var max_score: int

var dead_players_count := 0

func setup_score(size: int, game: Game) -> void:
	scores.resize(size)
	game.player_death.connect(_on_player_death)
	game.round_ended.connect(_on_round_ended)

func _on_player_death(player_id: int):
	dead_players_count += 1
	scores[player_id] += 10 - (scores.size() - dead_players_count)
	score_update.emit()

func _on_round_ended():
	dead_players_count = 0
	for score in scores:
		if score >= 50:
			max_score_reached.emit()
