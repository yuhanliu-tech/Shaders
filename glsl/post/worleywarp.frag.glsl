#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

const float pi = 3.14159265358979323846;

vec2 random2(vec2 p) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

float worleyNoise(vec2 uv) {

    uv *= 220.0;

    vec2 uvInt = floor(uv);

    vec2 uvFract = fract(uv);

    float minDist = 1.0;

    for (int y = -1; y <= 1; ++y) {
        for (int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y));
            vec2 point  = random2(uvInt + neighbor);
            vec2 diff = neighbor + point - uvFract;
            float dist = length(diff);
            minDist = min(minDist, dist);
        }
    }

    return minDist;

}

void main()
{
    // TODO Homework 5

    vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);
    float minDist = 0.5;

    if (worleyNoise(fs_UV) < minDist) {
        color = vec3(texture(u_RenderedTexture, fs_UV) + 0.7 * cos(worleyNoise(fs_UV) * u_Time * 0.3 * pi));
    } else {
        color = vec3(255,255,255);
    }



}

