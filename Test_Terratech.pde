PShader backgroundShader;
PShader inventaireShader;
PShader blocShader;
PShader debugShader;

float renderTime = 0;
float testTemps = 0;

void setup() {
  frameRate(70);
  size(1000, 800, P2D);
  surface.setTitle("PlaTech");
  surface.setResizable(true);

  /*
  PImage icon = new PImage();
   icon = loadImage("icon.png");
   surface.setIcon(icon);
   */

  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);
  noStroke();

  gameManager = new GameManager();
  hud = new HUD();

  SetupImages();

  map = new Map();
  camera = new Camera();

  mouseControl = new MouseControl();

  SetupShapes();

  backgroundShader = loadShader("Shaders/backgroundFrag.glsl", "Shaders/backgroundVert.glsl");
  backgroundShader.set("tailleCase", float(map.tailleCase));

  inventaireShader = loadShader("Shaders/inventaireFrag.glsl", "Shaders/inventaireVert.glsl");
  inventaireShader.set("tailleBlocs", map.tailleBlocs);

  blocShader = loadShader("Shaders/blocFrag.glsl", "Shaders/blocVert.glsl");
  blocShader.set("tailleBlocs", map.tailleBlocs);

  debugShader = loadShader("Shaders/debugFrag.glsl");
  debugShader.set("color", 0.0f, 0.0f, 0.0f, 0.5f);

  fill(255, 0);
}

void draw() {
  renderTime = millis() - testTemps;
  testTemps = millis();

  blocShader.set("resolution", float(width), float(height));
  //shader(backgroundShader);
  //background(#27813D);

  gameManager.PreUpdate();

  if (gameManager.isPlay()) {
    //Physics (à threader) (ou pas)
    map.Update();
  }

  if (!gameManager.isTitle()) {
    //Display
    push();
    camera.Update();
    camera.Translate();

    map.Display();

    pop();
  }

  gameManager.PostUpdate();

  hud.Display();

  /*
  shader(blocShader);
   shape(carreGRAND, 0, 0);
   resetShader();
   */
}
