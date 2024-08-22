shader_type canvas_item;

uniform vec2 direction = vec2(0.0, 1.0);
uniform float speed = 1.0;
uniform float alpha = 0.5;

void fragment() {
	vec4 color = texture(TEXTURE, UV + (direction * TIME * speed));
    color.a *= alpha;
	COLOR = color;
}