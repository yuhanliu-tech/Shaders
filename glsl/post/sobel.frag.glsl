#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

const float horizontal[9] = float[9](3,0,-3,10,0,-10,3,0,-3);
const float vertical[9] = float[9](3,10,3,0,0,0,-3,-10,-3);

void main()
{
    // TODO Homework 5

    //Multiply each of these kernels by the 3x3 set of pixels
    //surrounding a pixel to compute its gradients,
    //finding the sum of each of these multiplications.

    vec3 grad_h = vec3(0);
    vec3 grad_v = vec3(0);

    for (int i = 0; i < 9; i ++) {

        int x = i % 3;
        int y = int(floor(i/3));

        float pixels_x = fs_UV[0] + ((x - 1) / float(u_Dimensions[0]));
        float pixels_y = fs_UV[1] + ((y - 1) / float(u_Dimensions[1]));

        grad_h += horizontal[i] * vec3(texture(u_RenderedTexture, vec2(pixels_x, pixels_y)));
        grad_v += vertical[i] * vec3(texture(u_RenderedTexture, vec2(pixels_x, pixels_y)));
    }

    color = vec3(pow(grad_h[0] * grad_h[0] + grad_v[0] * grad_v[0],0.5),
            pow(grad_h[1] * grad_h[1] + grad_v[1] * grad_v[1],0.5),
            pow(grad_h[2] * grad_h[2] + grad_v[2] * grad_v[2],0.5));

    // - once you get texture at each point, sum components from horizontal and vertical
    // - grad = horizontal[] * color at that point


    //The final output will be a color represented as a vec3.

    //Once you have your horizontal and vertical color gradients,
    //square them, sum them, and set the output of your shader to the
    //square root that that sum.

    // distance between horizontal^2 and vertical^2
}
