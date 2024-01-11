shader_type canvas_item;

uniform vec4 color: source_color;
uniform float progress;
uniform float thickness;

varying float scale;

void vertex() {
	scale = MODEL_MATRIX[0][0];
	
}

void fragment() {
	float max_dist = 0.5;
	float min_dist = 0.5 - thickness / scale;
	float ring = 1.0 - step(max_dist, distance(UV, vec2(0.5))) - (1.0 - step(min_dist, distance(UV, vec2(0.5))));
	vec2 point = normalize(vec2(UV.x - 0.5, -UV.y + 0.5) * 2.0);
	float atan_a = atan(point.x, point.y);
	atan_a = (atan_a / TAU + 0.5);
	ring = ring * (1.0 - step(progress, atan_a));
	COLOR = vec4(color.rgb, ring);
}
