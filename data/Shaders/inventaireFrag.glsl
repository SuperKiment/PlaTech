#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec4 color;
uniform float tailleBlocs;
varying vec4 vPosition;
uniform float distAEnsemble;

#define PI 3.141592653
float trucChelou() {
  return 1-sin((vPosition.x/tailleBlocs)*PI) + 1-sin((vPosition.y/tailleBlocs)*PI);
}

void main() {  
  float dist = distAEnsemble;
  if (dist < 0) dist = 0;

  gl_FragColor = vec4(
  trucChelou()*0.2f,
  trucChelou()*0.2f, 
  trucChelou(), 
  (trucChelou()-0.9f)*dist);
}