uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

attribute vec4 position;

uniform vec4 color;
varying vec4 vPosition;

void main() {
  vPosition = position;
  gl_Position = transform * position;
}