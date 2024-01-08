extends Buff
class_name TrailThicknessBuff

@export var thickness_multiplier: float
@onready var timer = $Timer

func _ready() -> void:
	player.thickness *= thickness_multiplier
	timer.timeout.connect(_on_buff_finished)

func _on_buff_finished() -> void:
	player.thickness /= thickness_multiplier
	queue_free()
