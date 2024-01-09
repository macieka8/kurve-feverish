extends Buff
class_name PassThroughWallsBuff

@onready var timer = $Timer

func _ready() -> void:
	player.pass_through_walls_count += 1
	timer.timeout.connect(_on_buff_finished)

func _on_buff_finished() -> void:
	player.pass_through_walls_count -= 1
	queue_free()
