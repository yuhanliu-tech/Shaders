#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;

in vec2 fs_UV;

out vec3 color;
uniform sampler2D u_RenderedTexture;

void main()
{
    // TODO Homework 5

    vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);

    float darkness = diffuseColor[0] + diffuseColor[1] + diffuseColor[2];
    float minDist = darkness * sin(fs_UV[0] * u_Dimensions[0] + fs_UV[1] * u_Dimensions[1]);

    color = vec3(minDist);


}

