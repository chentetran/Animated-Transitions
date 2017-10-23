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
    txts.clear();
    PShape grp = createShape(GROUP);
    // axis
    float aW = i < aN ? w * i / (float)aN : w;
    float aH = i < aN ? h * i / (float)aN : h;
    grp.addChild(createShape(LINE, x, y + h, x + aW, y + h)); // x axis
    grp.addChild(createShape(LINE, x, y + h - aH, x, y + h)); // y axis
    // y tick and labels
    if (i > aN) {
      i -= aN;
      float fontH = textAscent() + textDescent();
      color fontClr = int(255 * (tN - i) / (float)tN);
      float yMax = tbl.getAxisMax(AXIS);
      float tW = TICKLEN * i / (float)tN;
      for (int j = 0; j < GAPS + 1; j++) {
        float tY = y + h * j / GAPS;
        grp.addChild(createShape(LINE, x - tW, tY, x, tY));
        String tStr = String.format("%.2f", yMax - (yMax * j / GAPS));
        txts.add(new TextInfo(tStr, x - TICKLEN - textWidth(tStr) - 5, tY + fontH / 2 - 3, 0, fontClr));
      }
      for (int j = 0; j < tbl.data.size(); j++) {
        float labelX = x + ((j + 0.3) * w/tbl.data.size());
        float labelY = y + h + 10;
        txts.add(new TextInfo(tbl.data.get(j).label, labelX, labelY, PI / 4, fontClr));
      }
    }
    shape = grp;
  }
  
  void fadeOut(int i, int n) {
    fadeIn(n - i, n);
  }
}