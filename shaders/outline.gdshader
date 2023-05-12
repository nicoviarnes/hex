shader_type canvas_item;

uniform float glow_amount : hint_range(0.0, 1.0) = 0.25;
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    COLOR.rgb += glow_color.rgb * glow_amount;
}
