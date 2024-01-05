extends Node

@onready var lobby := $"../../../.." as Lobby
@onready var rebinder := $"../../../../rebinder" as Rebinder

var entry_prefab = preload("res://scenes/UI/player_entry.tscn")

func _on_lobby_player_data_changed() -> void:
	remove_all_children()
	var i := 0
	for player in lobby.players:
		create_entry(i, player)
		i += 1

func remove_all_children() -> void:
	for child in get_children():
		child.queue_free()
	
func create_entry(player_id: int, player: PlayerData):
	var entry = entry_prefab.instantiate() as PlayerEntry
	entry.get_node(entry.id_label).text = "{id}".format({"id": player_id + 1})
	entry.get_node(entry.player_name).text = player.name
	entry.get_node(entry.left_key_bind).text = "" if player.left == null else player.left.as_text()
	entry.get_node(entry.right_key_bind).text = "" if player.right == null else player.right.as_text()
	
	entry.get_node(entry.left_key_bind).pressed.connect(_on_bind_requested.bind(player_id, 1))
	entry.get_node(entry.right_key_bind).pressed.connect(_on_bind_requested.bind(player_id, 2))
	
	add_child(entry)

func _on_bind_requested(player_id: int, turn: int) -> void:
	rebinder.rebind(player_id, turn)
