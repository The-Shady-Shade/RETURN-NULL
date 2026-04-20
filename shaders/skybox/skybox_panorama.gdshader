shader_type sky;

uniform sampler2D source_panorama: filter_linear, source_color, hint_default_black;
uniform sampler2D noise_panorama: filter_linear, source_color, hint_default_black;

void sky() {
	vec2 new_coord = SKY_COORDS;
	new_coord += TIME * 0.001;
	COLOR = texture(source_panorama, SKY_COORDS).rgb * 0.1 * texture(noise_panorama, new_coord).rgb;
}