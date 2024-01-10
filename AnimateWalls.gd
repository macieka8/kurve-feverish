extends Sprite2D

var is_animating: bool
var time_left: float

func _ready() -> void:
	Globals.animate_walls.connect(_on_animate_walls)

func _process(delta: float) -> void:
	if not is_animating:
		return
		
	time_left -= delta
	if time_left <= 0.0:
		(material as ShaderMaterial).set_shader_parameter("animate", false)

func _on_animate_walls(time: float) -> void:
	time_left = time
	is_animating = true
	(material as ShaderMaterial).set_shader_parameter("animate", true)
