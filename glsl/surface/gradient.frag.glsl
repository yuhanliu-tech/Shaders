#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec3 fs_Nor;
in vec3 fs_LightVec;

layout(location = 0) out vec3 out_Col;

const float pi = 3.14159265358979323846;

void main()
{
    // TODO Homework 4

    vec3 a = vec3(0.8, 0.5, 0.4);
    vec3 b = vec3(0.2, 0.4, 0.2);
    vec3 c = vec3(2.0, 1.0 ,1.0);
    vec3 d = vec3(0.0, 0.25, 0.25);

    float t = dot(normalize(fs_Nor), normalize(fs_LightVec));

    vec3 color = a + (b * cos(2 * pi * (t * c + d)));

    out_Col = color;
}
