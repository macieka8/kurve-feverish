extends Sprite2D
class_name BuffProgress

var buff: Buff
var progress := 1.0

func setup(buff: Buff) -> void:
	buff = buff;

func _ready() -> void:
	material = material.duplicate()
