precision mediump float;
precision mediump int;

uniform mat4 transformMatrix;
uniform mat4 texMatrix;

attribute vec4 position;
attribute vec2 texCoord;

// This will be passed to the fragment shader.
// It will not be used in this example and is included
// for explanatory purposes only.
varying vec4 vertTexCoord;

void main() {

  // Assign transform x position to built-in vertex
  // output gl_Position.
    gl_Position = transformMatrix * position;

  // Promote texCoord from a vec2 to a vec4, then
  // multiply with 4 x 4 matrix texMatrix.
    vertTexCoord = texMatrix * vec4(texCoord, 0.0, 1.0);
}