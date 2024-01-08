extends Node
class_name BuffSpawner

@export var pickable_buffs: Array[PackedScene]
@onready var buff_spawn_timer: Timer = $buff_spawn_timer
@onready var buffs_parent: Node = $buffs

func _ready() -> void:
	buff_spawn_timer.timeout.connect(_spawn_buff)

func _spawn_buff() -> void:
	var buff: Node2D = pickable_buffs[randi_range(0, pickable_buffs.size() - 1)].instantiate()
	buff.position = Vector2(randf_range(-310, 310), randf_range(-310, 310))
	buffs_parent.add_child(buff)

func _on_game_round_ended() -> void:
	for child in buffs_parent.get_children():
		child.queue_free()
