extends Node

@onready var score = %Score
@onready var game = $"../../.."
var player_score_entry = preload("res://scenes/player_score_entry.tscn")

var player_score_entries: Array[Node]

func _ready() -> void:
	score.score_update.connect(_on_score_update)
	for player in game.players:
		var instance = player_score_entry.instantiate()
		(instance.get_node("color") as ColorRect).color = player.color
		(instance.get_node("name") as Label).text = player.name
		player_score_entries.append(instance)
		add_child(instance)

func _on_score_update() -> void:
	var i := 0
	for entry in player_score_entries:
		(entry.get_node("score") as Label).text = "{score}".format({"score": score.scores[i]})
		_order_entry(entry)
		i += 1

func _order_entry(entry: Node) -> void:
	var i := 0
	var entry_score = entry.get_node("score").text.to_int()
	for child in get_children():
		if (child.get_node("score").text.to_int() <= entry_score):
			move_child(entry, i)
			break
		i += 1
