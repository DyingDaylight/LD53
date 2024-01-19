shader_type canvas_item;

const float TWO_PI = 6.28318530718;

vec3 hsb2rgb(in vec3 c) {
	vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
	rgb = rgb * rgb * (3.0 - 2.0 * rgb);
	return c.z * mix(vec3(1.0), rgb, c.y);
}

float pcurve(float x, float a, float b, float p) {
	float k = pow(a+b,a+b) / (pow(a,a)*pow(b,b)) * p;
    return k * pow( x, a ) * pow( 1.0 - x, b );
}

void fragment() {
	vec2 st = UV;
	vec3 color = vec3(0.0);
	
	float s = pcurve(st.x, 1.8, 4.0, 0.3) + 0.6;
	
	color = hsb2rgb(vec3(0.0, s, 0.5));
	COLOR = vec4(color, 1.0);
}