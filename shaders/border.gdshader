shader_type canvas_item;

uniform vec4 color: source_color;
uniform float thickness: hint_range(0.0, 1.0, 0.01);
uniform bool animate;

void fragment() {
	vec2 up_left = step(vec2(thickness, thickness), vec2(1.0, 1.0)-UV);
	vec2 down_right = step(vec2(thickness, thickness), UV);
	float value_a = 10.0;
	float speed = 1.0;
	if (animate) {
		up_left.x = up_left.x * step(0.0, sin(TAU * (TIME * speed + (UV.y) * value_a)));
		up_left.y = up_left.y * step(0.0, sin(TAU * (TIME * speed + (-UV.x) * value_a)));
		down_right.x = down_right.x * step(0.0, sin(TAU * (TIME * speed + (-UV.y) * value_a)));
		down_right.y = down_right.y * step(0.0, sin(TAU * (TIME * speed + (UV.x) * value_a)));
	}
	
	float transparency = up_left.x + up_left.y + down_right.x + down_right.y;
	COLOR = vec4(color.rgb, transparency);
}