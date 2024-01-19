shader_type canvas_item;

const vec3 colorA = vec3(0.249, 0.341, 0.712);
const vec3 colorB = vec3(0.500, 0.933, 0.524);

const float HALF_PI = PI / 2.0;

void fragment() {
	vec4 base = texture(TEXTURE, UV);
	vec3 color = vec3(0.0);
	
	float t = TIME * 0.5;
	
	float pct = abs(sin(TIME));	
	color = mix(colorA, colorB, pct);
	COLOR = vec4(color, base.a);
}