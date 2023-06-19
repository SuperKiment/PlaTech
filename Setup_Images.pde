void SetupImages() {
  basicHull = LoadBlocImage(6, "Textures_Blocs/Basic_Hull/");
}

PImage basicHull[];

PImage[] LoadBlocImage(int nb, String path) {
  PImage[] tabl = new PImage[nb];
  for (int i = 0; i<tabl.length; i++) {
    String no = "Basic_Hull_" + i + ".png";

    tabl[i] = loadImage(path + no);
  }
  return tabl;
}

HashMap<String, PShape> PShapes;

void SetupShapes() {
  PShapes = new HashMap<String, PShape>();
  
  PShapes.put("background", PShapeCreerCarre(map.tailleCase));
  PShapes.put("bloc", PShapeCreerCarre(int(map.tailleBlocs)));
  PShapes.put("1000", PShapeCreerCarre(1000));
  PShapes.put("100", PShapeCreerCarre(100));
  PShapes.put("debug", PShapeCreerrectangle(300, 400));

}

PShape PShapeCreerCarre(int taille) {
  PShape res;
  res = createShape();
  res.beginShape();

  res.vertex(0, 0);
  res.vertex(taille, 0);
  res.vertex(taille, taille);
  res.vertex(0, taille);

  res.endShape(CLOSE);
  return res;
}

PShape PShapeCreerrectangle(int tailleX, int tailleY) {
  PShape res;
  res = createShape();
  res.beginShape();

  res.vertex(0, 0);
  res.vertex(tailleX, 0);
  res.vertex(tailleX, tailleY);
  res.vertex(0, tailleY);

  res.endShape(CLOSE);
  return res;
}
