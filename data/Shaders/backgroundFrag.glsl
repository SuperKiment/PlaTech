#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec4 color;
uniform float tailleCase;
varying vec4 vPosition;
uniform float randomColor;


void main() {  
  //color = vec4(1.0f, 1.0f, 1.0f, 1.0f);
  vec3 color = vec3(0.0f, 0.7f, 0.2f) * randomColor;
  gl_FragColor = vec4(color, 1.0f);
  //gl_FragColor = vec4(vPosition.x/tailleCase,vPosition.y/tailleCase, 1.0f, 1.0f);
}