shader_type canvas_item;

uniform vec4 color: source_color;
uniform float thickness: hint_range(0.0, 1.0, 0.01);

void fragment() {
	vec2 up_left = step(vec2(thickness, thickness), vec2(1.0, 1.0)-UV);
	vec2 down_right = step(vec2(thickness, thickness), UV);
	COLOR = vec4(color.rgb, up_left.x + up_left.y + down_right.x + down_right.y);
}