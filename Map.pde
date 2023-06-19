Map map;

class Map {

  ArrayList<Ensemble> AllEnsembles;
  ArrayList<Item> AllItems;
  int tailleCase = 50;
  float tailleBlocs = 20;


  Map() {
    AllEnsembles = new ArrayList<Ensemble>();
    AllItems = new ArrayList<Item>();

    Ensemble e = new Ensemble(5, 5, true);
    Ensemble e2 = new Ensemble(10, 5, false);
    e2.focusable = false;

    AllEnsembles.add(e);
    AllEnsembles.add(e2);

    AllItems.add(new Item());
  }

  void Display() {
    resetShader();
    shader(backgroundShader);

    push();
    fill(255, 0);


    //rect(0, 0, width, height);
    int renderDistanceX = int((width/tailleCase)/2)+1;
    int renderDistanceY = int((height/tailleCase)/2)+1;

    for (int x = int(camera.focus.pos.x-renderDistanceX)*tailleCase; x<int(camera.focus.pos.x+renderDistanceX+1)*tailleCase; x+=tailleCase) {
      for (int y = int(camera.focus.pos.y-renderDistanceY)*tailleCase; y<int(camera.focus.pos.y+renderDistanceY+1)*tailleCase; y+=tailleCase) {
        backgroundShader.set("randomColor", map(
          noise((float(x)/float(tailleCase))/10f, (float(y)/float(tailleCase))/10f)
          , 0, 1,
          0.5, 1));
        shape(PShapes.get("background"), x, y);
      }
    }

    pop();
    resetShader();

    for (Ensemble e : AllEnsembles) {
      e.Display();
    }

    shader(blocShader);
    for (Item i : AllItems) {
      i.Display();
    }
    resetShader();

  }

  void Update() {
    for (int i=0; i<AllEnsembles.size(); i++) {
      //Ne faire que pour ceux qui sont dans l'écran (à ajouter)
      AllEnsembles.get(i).Update();
    }
  }
}
