
class Item {
  boolean isBloc = false;
  PVector pos;

  Item() {
    pos = new PVector(10, 10);
  }

  void Display() {
    shape(PShapes.get("bloc"), pos.x, pos.y);
  }
}
