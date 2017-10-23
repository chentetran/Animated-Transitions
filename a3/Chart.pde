abstract class Chart {
  DataTable tbl;
  float x, y, w, h;
  color on, off;
  ArrayList<Visual> vs;
  PShape shape = null;
  ArrayList<TextInfo> txts;
  protected color c;
  
  Chart(DataTable _tbl, float _x, float _y, float _w, float _h, color _on, color _off) {
    tbl = _tbl;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    on = _on;
    off = _off;
    c = _off;
    vs = new ArrayList<Visual>();
    txts = new ArrayList<TextInfo>();
    makeShape();
    makeVisuals();
  }
  
  void drawEmbellishments() {
    fill(0);
    if (shape != null) shape(shape);
    for (TextInfo txt : txts) {
      fill(txt.c);
      pushMatrix();
      translate(txt.x, txt.y);
      rotate(txt.a);
      text(txt.s, 0, 0);
      popMatrix();
    }
  }
  
  void drawVisuals() {
    for (Visual v : vs) v.draw();
  }
  
  void makeShape() {
    fadeIn(10, 10);
    for (Visual v : vs) v.makeShape();
  }
  
  void visualsToBars(Chart bchart, int i, int n) {
    for (int j = 0; j < vs.size(); j++) vs.get(j).toBar(bchart.vs.get(j), i, n);
  }
  
  void visualsToMarkers(Chart lchart, int i, int n) {
    for (int j = 0; j < vs.size(); j++) vs.get(j).toMarker(lchart.vs.get(j), i, n);
  }
  
  void visualsToSlices(Chart pchart, int i, int n) {
    for (int j = 0; j < vs.size(); j++) vs.get(j).toSlice(pchart.vs.get(j), i, n);
  }
  
  abstract void makeVisuals();
  abstract void fadeIn(int i, int n);
  abstract void fadeOut(int i, int n);
}