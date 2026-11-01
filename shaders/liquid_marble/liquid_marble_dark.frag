#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

out vec4 fragColor;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    f = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution;
    vec2 p = uv - 0.5;

    p.x *= uResolution.x / uResolution.y;

    float t = uTime * 0.22;

    // Smooth organic movement.
    p.x += sin(p.y * 3.2 + t) * 0.12;
    p.y += cos(p.x * 2.8 - t * 0.8) * 0.10;

    float n = noise(p * 3.0 + vec2(t * 0.35, -t * 0.2));

    float flow = sin(
        p.x * 4.0 + p.y * 2.5 + n * 5.0 + t
    );

    float darkFold = smoothstep(-0.25, 0.75, flow);
    float amberField = smoothstep(0.28, 0.72, n);
    float amberHighlight = smoothstep(
        0.60, 0.92, flow + n * 0.35
    );

    // Base: pure black.
    vec3 color = vec3(0.0);

    // Deep amber undertones.
    color = mix(
        color,
        vec3(0.12, 0.045, 0.0),
        amberField * 0.85
    );

    // Rich amber folds.
    color = mix(
        color,
        vec3(0.55, 0.25, 0.015),
        darkFold * amberField * 0.9
    );

    // PlotLine signature amber: #F59E0B.
    color = mix(
        color,
        vec3(0.961, 0.620, 0.043),
        amberHighlight * amberField * 0.75
    );

    // Soft dark edges.
    float vignette = 1.0 - smoothstep(
        0.25, 0.78, length(p * vec2(0.85, 1.0))
    );

    color *= 0.72 + vignette * 0.28;

    fragColor = vec4(color, 1.0);
}