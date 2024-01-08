extends Area2D
class_name PowerUp

@export var buff : PackedScene

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var buff_instance := buff.instantiate() as Buff
		buff_instance.setup(body)
		body.add_child(buff_instance)
		queue_free()
