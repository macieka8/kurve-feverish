extends Sprite2D

@onready var player := $".."

func _ready() -> void:
	material = material.duplicate()
	(material as ShaderMaterial).set_shader_parameter("color", player.player_data.color)
