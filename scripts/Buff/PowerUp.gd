extends Area2D
class_name PowerUp

@export var buff : PackedScene
@export var buff_source := BuffSource.BuffSource.ME

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var found_player := body as Player
		match buff_source:
			BuffSource.BuffSource.ME:
				var buff_instance := buff.instantiate() as Buff
				buff_instance.setup(found_player)
				found_player.add_child(buff_instance)
				found_player.buff_displayer.add_buff(buff_instance)
			BuffSource.BuffSource.ALL_PLAYERS:
				var players = get_tree().get_nodes_in_group("player")
				for player in players:
					var buff_instance := buff.instantiate() as Buff
					buff_instance.setup(player)
					player.add_child(buff_instance)
					player.buff_displayer.add_buff(buff_instance)
			BuffSource.BuffSource.OTHER_PLAYERS:
				var players = get_tree().get_nodes_in_group("player")
				for player in players:
					if player == found_player:
						continue
					var buff_instance := buff.instantiate() as Buff
					buff_instance.setup(player)
					player.add_child(buff_instance)
					player.buff_displayer.add_buff(buff_instance)
		queue_free()
