extends Node

@onready var lobby := owner as Lobby
@onready var rebinder := %rebinder as Rebinder

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
	entry.get_node("id").text = "{id}".format({"id": player_id + 1})
	
	var player_name_text := entry.get_node("player-name") as LineEdit
	player_name_text.text = player.name
	player_name_text.text_changed.connect(_on_change_player_name.bind(player_id))
	
	var left_key_bind_button := entry.get_node("left-key-bind") as Button
	left_key_bind_button.text = "" if player.left == null else player.left_name
	left_key_bind_button.pressed.connect(_on_bind_requested.bind(player_id, 1))
	
	var right_key_bind_button := entry.get_node("right-key-bind") as Button
	right_key_bind_button.text = "" if player.right == null else player.right_name
	right_key_bind_button.pressed.connect(_on_bind_requested.bind(player_id, 2))
	
	var delete_player_button := entry.get_node("delete-player") as Button
	delete_player_button.pressed.connect(lobby.remove_player.bind(player_id))
	
	var color_button = entry.get_node("color-button") as ColorPickerButton
	color_button.color = player.color
	color_button.color_changed.connect(lobby.change_player_color.bind(player_id))
	
	add_child(entry)

func _on_change_player_name(new_text: String, player_id: int) -> void:
	lobby.players[player_id].name = new_text

func _on_bind_requested(player_id: int, turn: int) -> void:
	rebinder.rebind(player_id, turn)
