extends Buff
class_name ReverseControlsBuff

@onready var timer = $Timer

func _ready() -> void:
	player.reverse_controls_count += 1
	timer.timeout.connect(_on_buff_finished)

func _on_buff_finished() -> void:
	player.reverse_controls_count -= 1
	queue_free()
