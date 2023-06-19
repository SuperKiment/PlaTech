class Ensemble {

  PVector pos, vel, dirCible, dir, taille;
  boolean controllable = false, focusable = true;
  float speed = 0.1, rotSpeed = 0.05;
  String name = "";

  Inventaire inventaire;

  Grille grille;

  Ensemble() {
    Constructor();
  }

  Ensemble(float x, float y, boolean c) {
    Constructor();
    pos = new PVector(x, y);
    controllable = c;
  }

  void Constructor() {
    pos = new PVector();
    vel = new PVector();
    dirCible = new PVector();
    dir = new PVector();
    taille = new PVector(50, 50);

    grille = new Grille();

    inventaire = new Inventaire();
  }

  void Display() {
    push();
    translate(pos.x*map.tailleCase, pos.y*map.tailleCase);

    dir.lerp(dirCible, rotSpeed);

    rotate(dir.heading());

    grille.Display();

    pop();
    //if (controllable) inventaire.Display(5);
  }

  void Update() {
    Deplacement();
  }

  void Deplacement() {
    if (controllable) dirCible = inputControl.keyDir;

    vel = dirCible;
    vel.setMag(speed);

    pos.add(vel);
  }

  boolean IsOnThis(float x, float y) {
    float tailleCase = map.tailleCase;
    if (x - camera.translate.x >= pos.x * tailleCase - taille.x/2 &&
      x - camera.translate.x <= pos.x * tailleCase + taille.x/2 &&
      y - camera.translate.y >= pos.y * tailleCase - taille.y/2 &&
      y - camera.translate.y <= pos.y * tailleCase + taille.y/2) {
      return true;
    } else return false;
  }

  String Print() {
    String pr = name;
    if (pr.equals("")) pr = "NoName";

    return "[Ensemble " + pr + " / Position " + pos + "]";
  }


  //------------------------------------------------------GRILLE


  class Grille {

    ArrayList<Bloc> AllBlocs;
    Bloc [][] grilleBlocs;
    boolean isDisplay = true;
    color colGrilleStroke = color(#4BFAFF);
    color colGrilleFond = color(#2A8B74);

    Grille() {
      AllBlocs = new ArrayList<Bloc>();
      grilleBlocs = new Bloc[25][25];

      AddBloc(new Bloc(), 12, 13);
      AddBloc(new Bloc(), 13, 12);
      AddBloc(new Bloc(), 13, 13);
      AddBloc(new Bloc(), 12, 11);
      AddBloc(new Bloc(), 13, 11);
      AddBloc(new Bloc(), 11, 12);
      AddBloc(new Bloc(), 10, 12);
      AddBloc(new Bloc(), 9, 12);
    }

    void Display() {
      push();
      shader(inventaireShader);

      float tailleX = map.tailleBlocs * grilleBlocs.length;
      float tailleY = map.tailleBlocs * grilleBlocs[0].length;
      translate(-tailleX/2, -tailleY/2);
      translate(map.tailleBlocs/2, map.tailleBlocs/2);

      //---------------------------------------------------------GRILLE
      if (controllable && inputControl.b) {
        push();
        translate(-map.tailleBlocs/2, -map.tailleBlocs/2);
        //rectMode(CENTER);


        float maxTailleX = (grilleBlocs.length-1)*map.tailleBlocs
          , maxTailleY = (grilleBlocs[0].length-1)*map.tailleBlocs;
        float distVueCarres = maxTailleX/1.5;

        for (int x=0; x<=maxTailleX; x+=map.tailleBlocs) {
          for (int y=0; y<=maxTailleY; y+=map.tailleBlocs) {
            inventaireShader.set("distAEnsemble", 1-map(dist(x, y, maxTailleX/2, maxTailleY/2), 0, distVueCarres, 0, 1));
            shape(PShapes.get("bloc"), x, y);
          }
        }


        pop();
      }
      //-------------------------------------------------------------------
      resetShader();

      shader(blocShader);
      blocShader.set("texture", basicHull[4]);
      
      for (Bloc b : AllBlocs) {
        PVector posBloc = new PVector(b.posInGrille.x*map.tailleBlocs, b.posInGrille.y*map.tailleBlocs);
        grilleBlocs[int(b.posInGrille.x)][int(b.posInGrille.y)].Display(posBloc.x, posBloc.y);
      }
      resetShader();

      /*
      for (int x=0; x<grilleBlocs.length; x++) {
       for (int y=0; y<grilleBlocs[0].length; y++) {
       if (grilleBlocs[x][y] != null) {
       PVector posBloc = new PVector(x*map.tailleBlocs, y*map.tailleBlocs);
       grilleBlocs[x][y].Display(posBloc.x, posBloc.y);
       }
       }
       }
       */
      pop();
    }

    void AddBloc(Bloc b, int x, int y) {
      if (grilleBlocs[x][y] == null) {
        grilleBlocs[x][y] = b;
        AllBlocs.add(b);
        b.posInGrille.set(x, y);
      }
    }
  }
}

//=====================================================================
//                               BLOC
//=====================================================================

enum BlocType {
  Classic, Hard, Turret;
}

class Bloc extends Item {

  PVector taille, posInGrille;
  BlocType blocType = BlocType.Classic;

  Bloc() {
    Constructor();
  }

  Bloc(BlocType b) {
    Constructor();
    blocType = b;
  }

  void Constructor() {
    isBloc = true;
    taille = new PVector(1, 1);
    blocType = BlocType.Classic;
    posInGrille = new PVector(0, 0);
  }

  void Update() {
  }

  void Display(float x, float y) {
    shape(PShapes.get("bloc"), x, y);
    
  }
}

//=====================================================================
//                               INVENTAIRE
//=====================================================================

class Inventaire {
  ArrayList<Item> items;
  float tailleCases = 40, ecart = 5;
  int nbMax = 50;

  Inventaire() {
    items = new ArrayList<Item>();

    for (int i=0; i<50; i++) {
      addItem(new Bloc());
    }
  }

  void Display(int nbColonnes) {
    int colonne = 0, ligne = 0;
    for (int i=0; i<items.size(); i++) {
      if (colonne == nbColonnes) {
        colonne = 0;
        ligne++;
      }
      rect(colonne*(tailleCases+ecart), ligne*(tailleCases+ecart), tailleCases, tailleCases);

      colonne++;
    }
  }

  boolean addItem(Item i) {
    if (items.size() < nbMax) {
      items.add(i);
      return true;
    }
    return false;
  }
}
