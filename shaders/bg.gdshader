shader_type canvas_item;

uniform float time_scale = 0.1;
uniform vec4 color1 = vec4(1.0, 0.5, 0.5, 1.0);
uniform vec4 color2 = vec4(0.0, 0.5, 1.0, 1.0);
uniform float zoom = 5.0;
uniform float detail = 1.0;

float fractal(vec2 uv) {
    float sum = 0.0;
    vec2 p = uv * zoom;
    float freq = 1.0;
    float amp = 1.0;
    for (int i = 0; i < 6; i++) {
        sum += sin(p.x + p.y) * amp;
        p *= 2.0;
        freq *= 2.0;
        amp *= 0.5;
    }
    return sum;
}

void fragment() {
    vec2 uv = SCREEN_UV;
    float time = TIME * time_scale;
    float f = fractal(uv + vec2(time, 0.0)) * detail;
    vec4 color = mix(color1, color2, f);
    COLOR = color;
}
