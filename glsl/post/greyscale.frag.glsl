#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

void main()
{
    // TODO Homework 5

    vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);

    // VIGNETTE
    float dist = pow( pow(0.5 - fs_UV[0], 2) + pow(0.5 - fs_UV[1], 2), 0.5);
    diffuseColor -= ( 1.5 * pow(dist, 2) );


    // GRAYSCALE
    float grey = 0.21 * diffuseColor.r + 0.72 * diffuseColor.g + 0.07 * diffuseColor.b;
    color = vec3(grey, grey, grey);
}
