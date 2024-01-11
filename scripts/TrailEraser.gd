extends Node

func _ready() -> void:
	Globals.erase_trails.connect(_erase_trails)

func _erase_trails() -> void:
	var trails = get_tree().get_nodes_in_group("trail")
	for trail in trails:
		trail.queue_free()
