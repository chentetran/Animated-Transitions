final float TICKLEN = 5;
final int GAPS = 10;

class BarChart extends Chart {
  BarChart(DataTable _tbl, float _x, float _y, float _w, float _h) {
    super(_tbl, _x, _y, _w, _h);
  }
  
  void makeShape() {
    super.makeShape();
  }
  
  void makeVisuals() {
    vs.clear();
    stroke(0);
    fill(255);
    float gapSize = w / tbl.data.size();
    float rectWid = 0.8 * gapSize;
    float xStart = x + (gapSize - rectWid) / 2;
    float hgtRatio = h / tbl.getAxisMax(0);
    for (int i = 0; i < tbl.data.size(); i++) {
      DataPoint pt = tbl.data.get(i);
      float rectHgt = pt.values.get(AXIS) * hgtRatio;
      vs.add(new Bar(pt, xStart + gapSize * i, y + h - rectHgt, rectWid, rectHgt));
    }
  }
  
  void fadeIn(int i, int n) {
    int aN = int(n * 0.7); // axis
    int tN = n - aN; // ticks
    PShape grp = createShape(GROUP);
    // axis
    float aW = i < aN ? w * i / (float)aN : w;
    float aH = i < aN ? h * i / (float)aN : h;
    grp.addChild(createShape(LINE, x, y + h, x + aW, y + h)); // x axis
    grp.addChild(createShape(LINE, x, y + h - aH, x, y + h)); // y axis
    // y ticks
    if (i > aN) {
      float tW = TICKLEN * (i - aN) / (float)tN;
      for (int j = 0; j < GAPS + 1; j++) {
        float tY = y + h * j / GAPS;
        grp.addChild(createShape(LINE, x - tW, tY, x, tY));
      }
    }
    shape = grp;
  }
  
  void fadeOut(int i, int n) {
    int tN = int(n * 0.3); // ticks
    int aN = n - tN; // axis
    PShape grp = createShape(GROUP);
    // ticks
    if (i <= tN) {
      float tW = TICKLEN * (tN - i) / (float)tN;
      for (int j = 0; j < GAPS + 1; j++) {
        float tY = y + h * j / GAPS;
        grp.addChild(createShape(LINE, x - tW, tY, x, tY));
      }
    }
    // axis
    float aW = i > tN ? w * (aN - (i - tN)) / (float)aN : w;
    float aH = i > tN ? h * (aN - (i - tN)) / (float)aN : h;
    grp.addChild(createShape(LINE, x, y + h, x + aW, y + h)); // x axis
    grp.addChild(createShape(LINE, x, y + h - aH, x, y + h)); // y axis
    shape = grp;
  }
}