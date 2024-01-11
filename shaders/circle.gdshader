shader_type canvas_item;

uniform vec4 color: source_color;

void fragment() {
	float value = 1.0 - step(0.5, distance(UV, vec2(0.5)));
	COLOR = vec4(color.rgb, value);
}
