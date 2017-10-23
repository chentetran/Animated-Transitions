final float BORDER = 20;

abstract class Visual {
  DataPoint pt;
  float x, y, w, h, r, a1, a2;
  color on, off;
  PShape shape = null;
  protected color c;
  
  Visual(DataPoint _pt, float _x, float _y, color _on, color _off) {
    pt = _pt;
    x = _x;
    y = _y;
    on = _on;
    off = _off;
    c = _off;
  }
  
  void draw() {
    if (shape != null) shape(shape);
  }
  
  void setColor() {
    stroke(0);
    fill(c);
  }
  
  void onOver() {
    c = on;
  }
  
  void onOff() {
    c = off;
  }
  
  abstract void makeShape();
  abstract boolean isOver();
  abstract void toBar(Visual bar, int i, int n);
  abstract void toMarker(Visual marker, int i, int n);
  abstract void toSlice(Visual slice, int i, int n);
}