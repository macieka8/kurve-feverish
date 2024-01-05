extends Node
class_name Rebinder

@onready var lobby := $".." as Lobby

var turn: int
var rebinding_player_id: int

func _unhandled_input(event: InputEvent) -> void:
	if turn == 0:
		return
	if event is InputEventKey:
		
		if turn == 1:
			lobby.players[rebinding_player_id].left = event.keycode
			lobby.players[rebinding_player_id].left_name = event.as_text()
			
		elif turn == 2:
			lobby.players[rebinding_player_id].right = event.keycode
			lobby.players[rebinding_player_id].right_name = event.as_text()
		turn = 0
		lobby.player_data_changed.emit()

func rebind(player_id: int, turn: int) -> void:
	self.turn = turn
	rebinding_player_id = player_id
