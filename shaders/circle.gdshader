shader_type canvas_item;

uniform vec4 color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float value = 1.0 - step(0.5, distance(UV, vec2(0.5)));
	COLOR = vec4(color.rgb, value);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
