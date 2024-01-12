extends Node
class_name BuffSpawner

@export var pickables: Array[PackedScene]

var pickables_path := "res://scenes/Buff/pickable_generated/"

@onready var buff_spawn_timer: Timer = $buff_spawn_timer
@onready var buffs_parent: Node = $buffs

func _ready() -> void:
	var pickables_dir = DirAccess.open(pickables_path)
	for file_name in pickables_dir.get_files():
		var pickable = ResourceLoader.load(pickables_path + file_name.trim_suffix(".remap"))
		pickables.push_back(pickable)
	buff_spawn_timer.timeout.connect(_spawn_buff)

func _spawn_buff() -> void:
	var buff: Node2D = pickables[randi_range(0, pickables.size() - 1)].instantiate()
	buff.position = Vector2(randf_range(-310, 310), randf_range(-310, 310))
	buffs_parent.add_child(buff)

func _on_game_round_ended() -> void:
	for child in buffs_parent.get_children():
		child.queue_free()
