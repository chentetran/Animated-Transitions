abstract class Visual {
  DataPoint pt;
  float x, y, w, h, r, a1, a2;
  PShape shape = null;
  
  Visual(DataPoint _pt, float _x, float _y) {
    pt = _pt;
    x = _x;
    y = _y;
  }
  
  void draw() {
    if (shape != null) shape(shape);
  }
  
  abstract void makeShape();
  abstract void toBar(Visual bar, int i, int n);
  abstract void toMarker(Visual marker, int i, int n);
  abstract void toSlice(Visual slice, int i, int n);
}