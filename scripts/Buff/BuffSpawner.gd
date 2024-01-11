extends Node
class_name BuffSpawner

const pickable_buffs_dir_name := "res://scenes/Buff/pickable_generated/"

@export var pickables: Array[PackedScene]

@onready var buff_spawn_timer: Timer = $buff_spawn_timer
@onready var buffs_parent: Node = $buffs

func _ready() -> void:
	buff_spawn_timer.timeout.connect(_spawn_buff)
	var pickable_buffs_dir := DirAccess.open(pickable_buffs_dir_name)
	for file_name in pickable_buffs_dir.get_files():
		var pickable_buff = load(pickable_buffs_dir_name + file_name)
		pickables.push_back(pickable_buff)

func _spawn_buff() -> void:
	var buff: Node2D = pickables[randi_range(0, pickables.size() - 1)].instantiate()
	buff.position = Vector2(randf_range(-310, 310), randf_range(-310, 310))
	buffs_parent.add_child(buff)

func _on_game_round_ended() -> void:
	for child in buffs_parent.get_children():
		child.queue_free()
