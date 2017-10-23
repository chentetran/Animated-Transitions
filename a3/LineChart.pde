final float MRK_RADIUS = 5;

class LineChart extends Chart {
  LineChart(DataTable _tbl, float _x, float _y, float _w, float _h, color _on, color _off) {
    super(_tbl, _x, _y, _w, _h, _on, _off);
  }
  
  private float getPtX(int i) {
    float gapSize = w / tbl.data.size();
    return x + gapSize / 2 + gapSize * i;
  }
  
  private float getPtY(int i) {
    return getPtY(i, tbl.getAxisMax(0)); 
  }
  
  private float getPtY(int i, float yMax) {
    float heightRatio = h / yMax;
    return y + h - tbl.data.get(i).values.get(AXIS) * heightRatio;
  }
  
  void makeVisuals() {
    vs.clear();
    stroke(0);
    fill(255);
    float yMax = tbl.getAxisMax(0);
    for (int i = 0; i < tbl.data.size(); i++) {
      float mY = getPtY(i, yMax);
      float mH = y + h - mY;
      vs.add(new Marker(tbl.data.get(i), getPtX(i), mY, mH, MRK_RADIUS, on, off));
    }
  }
  
  void fadeIn(int i, int n) {
    int aN = int(n * 0.4); // axis
    int tN = int(n * 0.1); // ticks
    int lN = n - aN - tN; // lines
    txts.clear();
    PShape grp = createShape(GROUP);
    // axis
    float aW = i < aN ? w * i / (float)aN : w;
    float aH = i < aN ? h * i / (float)aN : h;
    grp.addChild(createShape(LINE, x, y + h, x + aW, y + h)); // x axis
    grp.addChild(createShape(LINE, x, y + h - aH, x, y + h)); // y axis
    // y ticks
    if (i > aN) {
      float ratio = (i - aN) < tN ? (i - aN) / (float)tN : 1;
      float fontH = textAscent() + textDescent();
      color fontClr = int(255 * (1 - ratio));
      float yMax = tbl.getAxisMax(AXIS);
      float tW = TICKLEN * ratio;
      for (int j = 0; j < GAPS + 1; j++) {
        float tY = y + h * j / GAPS;
        grp.addChild(createShape(LINE, x - tW, tY, x, tY));
        String tStr = String.format("%.2f", yMax - (yMax * j / GAPS));
        txts.add(new TextInfo(tStr, x - TICKLEN - textWidth(tStr) - 5, tY + fontH / 2 - 3, 0, fontClr));
      }
      for (int j = 0; j < tbl.data.size(); j++) {
        float labelX = x + ((j + 0.45) * w/tbl.data.size());
        float labelY = y + h + 10;
        txts.add(new TextInfo(tbl.data.get(j).label, labelX, labelY, PI / 4, fontClr));
      }
    }
    // lines
    if (i > lN) {
      float yMax = tbl.getAxisMax(0);
      for (int j = 0; j < tbl.data.size() - 1; j++) {
        float x1 = getPtX(j), x2 = getPtX(j+1), y1 = getPtY(j, yMax), y2 = getPtY(j+1, yMax);
        float xDiff = x2 - x1, yDiff = y2 - y1, diffRatio = (i - aN - tN) / (float)lN;
        grp.addChild(createShape(LINE, x1, y1, x1 + xDiff * diffRatio, y1 + yDiff * diffRatio));
      }
    }
    shape = grp;
  }
  
  void fadeOut(int i, int n) {
    fadeIn(n - i, n);
  }
}