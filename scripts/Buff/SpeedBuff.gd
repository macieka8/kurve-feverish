extends Buff
class_name SpeedBuff

@export var speed_multiplier: float
@onready var timer = $Timer

func _ready() -> void:
	player.speed *= speed_multiplier
	timer.timeout.connect(_on_buff_finished)

func _on_buff_finished() -> void:
	player.speed /= speed_multiplier
	queue_free()
