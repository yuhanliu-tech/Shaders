#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform int u_Time;

in vec3 fs_Pos;
in vec3 fs_Nor;
in vec3 fs_LightVec;

const float pi = 3.14159265358979323846;

layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4

    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(2.0, 1.0 ,1.0);
    vec3 d = vec3(0.5, 0.2, 0.5);

    float t = dot(normalize(fs_Nor), normalize(fs_LightVec));

    vec3 color = a + (b * cos(2 * pi * (((0.5*t) + (float(u_Time)*0.1)) * c + d)));

    out_Col = color;
}
