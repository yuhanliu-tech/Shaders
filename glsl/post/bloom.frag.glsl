#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

const float kernel[121] = float[121](
            0.006849, 0.007239, 0.007559, 0.007795, 0.007941, 0.00799, 0.007941, 0.007795, 0.007559, 0.007239, 0.006849, 0.007239, 0.007653, 0.00799, 0.00824, 0.008394, 0.008446, 0.008394, 0.00824, 0.00799, 0.007653, 0.007239, 0.007559, 0.00799, 0.008342, 0.008604, 0.008764, 0.008819, 0.008764, 0.008604, 0.008342, 0.00799, 0.007559, 0.007795, 0.00824, 0.008604, 0.008873, 0.009039, 0.009095, 0.009039, 0.008873, 0.008604, 0.00824, 0.007795, 0.007941, 0.008394, 0.008764, 0.009039, 0.009208, 0.009265, 0.009208, 0.009039, 0.008764, 0.008394, 0.007941, 0.00799, 0.008446, 0.008819, 0.009095, 0.009265, 0.009322, 0.009265, 0.009095, 0.008819, 0.008446, 0.00799, 0.007941, 0.008394, 0.008764, 0.009039, 0.009208, 0.009265, 0.009208, 0.009039, 0.008764, 0.008394, 0.007941, 0.007795, 0.00824, 0.008604, 0.008873, 0.009039, 0.009095, 0.009039, 0.008873, 0.008604, 0.00824, 0.007795, 0.007559, 0.00799, 0.008342, 0.008604, 0.008764, 0.008819, 0.008764, 0.008604, 0.008342, 0.00799, 0.007559, 0.007239, 0.007653, 0.00799, 0.00824, 0.008394, 0.008446, 0.008394, 0.00824, 0.00799, 0.007653, 0.007239, 0.006849, 0.007239, 0.007559, 0.007795, 0.007941, 0.00799, 0.007941, 0.007795, 0.007559, 0.007239, 0.006849);

const int n = 9;
const float threshold = 0.4;

void main()
{
    // TODO Homework 5

    vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);
    vec3 avg = vec3(0);
    int width = int(floor(n/2));

    // To implement bloom,
    // one needs to take a weighted average of all the pixels surrounding
    // the current pixel, but only factor them into the average if their
    // luminance is above a given threshold.

    // The higher the threshold, the smaller the bloom effect.
    // Once one has acquired this weighted average, one just adds it
    // to the base color of the current pixel.

    for (int i = 0; i < n * n; i ++) {

        int x = i % n;
        int y = int(floor(i/n));

        float weight = kernel[x + (width * y)];

        float pixel_in_radius_x = fs_UV[0] + ((x - width) / float(u_Dimensions[0]));
        float pixel_in_radius_y = fs_UV[1] + ((y - width) / float(u_Dimensions[1]));

        vec3 color = vec3(texture(u_RenderedTexture, vec2(pixel_in_radius_x, pixel_in_radius_y)));
        float luminance = color[0] * 0.2126 + color[1] * 0.7152 + color[2] * 0.0722;

        if (luminance > threshold) {
            avg += vec3(texture(u_RenderedTexture, vec2(pixel_in_radius_x, pixel_in_radius_y)) * weight);
        }

    }

    color = vec3(texture(u_RenderedTexture, fs_UV)) + avg;
}
