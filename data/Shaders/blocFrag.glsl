#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec4 color;
varying vec4 vPosition;
uniform sampler2D texture;
uniform vec2 resolution;
uniform float tailleBlocs;

#define PI 3.141592653
float trucChelou() {
  return 1-sin((vPosition.x/tailleBlocs)*PI) * 1-sin((vPosition.y/tailleBlocs)*PI);
}
void main() {  
  /*
  //gl_FragColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
  vec2 p = vPosition.xy / tailleBlocs;
  vec2 uv = vec2(0.5f, 0.5f) + p * 0.5f;
  vec4 color = texture2D(texture, vPosition.xy / tailleBlocs);
  gl_FragColor = vec4(color);
  */


    vec3 color = vec3(1.0f, trucChelou(), trucChelou());
  gl_FragColor = vec4(color, 1-trucChelou()-1.0f);

}