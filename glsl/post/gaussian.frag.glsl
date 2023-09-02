#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

const float kernel[121] = float[121](
            0.006849, 0.007239, 0.007559, 0.007795, 0.007941, 0.00799, 0.007941, 0.007795, 0.007559, 0.007239, 0.006849, 0.007239, 0.007653, 0.00799, 0.00824, 0.008394, 0.008446, 0.008394, 0.00824, 0.00799, 0.007653, 0.007239, 0.007559, 0.00799, 0.008342, 0.008604, 0.008764, 0.008819, 0.008764, 0.008604, 0.008342, 0.00799, 0.007559, 0.007795, 0.00824, 0.008604, 0.008873, 0.009039, 0.009095, 0.009039, 0.008873, 0.008604, 0.00824, 0.007795, 0.007941, 0.008394, 0.008764, 0.009039, 0.009208, 0.009265, 0.009208, 0.009039, 0.008764, 0.008394, 0.007941, 0.00799, 0.008446, 0.008819, 0.009095, 0.009265, 0.009322, 0.009265, 0.009095, 0.008819, 0.008446, 0.00799, 0.007941, 0.008394, 0.008764, 0.009039, 0.009208, 0.009265, 0.009208, 0.009039, 0.008764, 0.008394, 0.007941, 0.007795, 0.00824, 0.008604, 0.008873, 0.009039, 0.009095, 0.009039, 0.008873, 0.008604, 0.00824, 0.007795, 0.007559, 0.00799, 0.008342, 0.008604, 0.008764, 0.008819, 0.008764, 0.008604, 0.008342, 0.00799, 0.007559, 0.007239, 0.007653, 0.00799, 0.00824, 0.008394, 0.008446, 0.008394, 0.00824, 0.00799, 0.007653, 0.007239, 0.006849, 0.007239, 0.007559, 0.007795, 0.007941, 0.00799, 0.007941, 0.007795, 0.007559, 0.007239, 0.006849);

const int n = 11;

void main()
{
    // TODO Homework 5

    vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);

    // vec2 adjacent_pixel = fs_UV + 1 / u_Dimensions

    //A Gaussian blur effectively performs a weighted average of NxN pixels
    //and stores the result in the pixel at the center of that NxN box
    //(this means N must always be odd). The larger the blur radius,
    //the smoother the blur will be. Additionally, altering the weighting of the
    //blur will increase or decrease its intensity. x + (width * y)

    vec3 avg = vec3(0);
    int width = int(floor(n/2));

    for (int i = 0; i < n * n; i ++) {

        int x = i % n;
        int y = int(floor(i/n));

        float weight = kernel[x + (width * y)];

        float pixel_in_radius_x = fs_UV[0] + ((x - width) / float(u_Dimensions[0]));
        float pixel_in_radius_y = fs_UV[1] + ((y - width) / float(u_Dimensions[1]));

        avg += vec3(texture(u_RenderedTexture, vec2(pixel_in_radius_x, pixel_in_radius_y)) * weight);

    }

    //create a const array of 121 floats just above main(),
    //hard-coding into it the kernel values from the Gaussian kernel
    //generator here. Index into this array the same way you did your
    //Z-buffer in hw03 to treat it like an 11x11 array.

    //We used a gamma value of 9 in the generator linked above.

    color = avg;
}
