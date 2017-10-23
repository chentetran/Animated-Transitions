class PieChart extends Chart {
  PieChart(DataTable _tbl, float _x, float _y, float _w, float _h) {
    super(_tbl, _x, _y, _w, _h);
  }
  
  void makeVisuals() {
    vs.clear();
    stroke(0);
    fill(255);
    float offset = 0, ySum = tbl.getAxisSum(0);
    float sx = x + w / 2, sy = y + h / 2, r = min(w, h) / 2;
    for (DataPoint pt : tbl.data) {
      float angle = TWO_PI * pt.values.get(AXIS) / ySum;
      vs.add(new Slice(pt, sx, sy, r, offset, offset + angle));
      offset += angle;
    }
  }
  
  void fadeIn(int i, int n) {
  }
  
  void fadeOut(int i, int n) {
  }
}