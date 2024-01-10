extends Buff
class_name InvincibleBuff

@onready var timer = $Timer

func _ready() -> void:
	player.invinsible_count += 1
	timer.timeout.connect(_on_buff_finished)

func _on_buff_finished() -> void:
	player.invinsible_count -= 1
	queue_free()
