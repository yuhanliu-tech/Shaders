#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;
uniform vec3 u_Pos;

uniform int u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec3 fs_Pos;
out vec3 fs_Nor;
out vec3 fs_LightVec;

void main()
{
    // TODO Homework 4
    fs_Nor = normalize(u_ModelInvTr * vec3(vs_Nor));

    vec4 modelposition = u_Model * vs_Pos;

    // want to rotate yz coords

    float t = cos(float(u_Time) * 0.1);
    t *= length(modelposition.yz) * 0.25;

    modelposition.y = cos(t) * modelposition.y + sin(t) * modelposition.z;
    modelposition.z = -sin(t) * modelposition.y + cos(t) * modelposition.z;

    fs_LightVec = vec3(vec4(u_Pos,1) - modelposition);

    fs_Pos = vec3(modelposition);
    gl_Position = u_Proj * u_View * modelposition;
}
