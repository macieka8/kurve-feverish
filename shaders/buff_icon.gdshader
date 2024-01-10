shader_type canvas_item;

uniform vec3 color: source_color;

void fragment() {
	vec4 background_color = vec4(1.0 - COLOR.rgb, COLOR.a);
	background_color = background_color * vec4(color.rgb, 1.0);
	COLOR = COLOR + background_color;
}