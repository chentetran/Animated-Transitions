final float MRK_WIDTH = 10;

class LineChart extends AxisChart {
  LineChart(DataTable tbl, float x, float y, float w, float h, color on, color off) {
    super(tbl, x, y, w, h, on, off);
  }
  
  private float getPtX(int i) {
    float gapSize = w / tbl.data.size();
    return x + gapSize / 2 + gapSize * i;
  }
  
  private float getPtY(int i) {
    return getPtY(i, super.getAxisMax(0)); 
  }
  
  private float getPtY(int i, float yMax) {
    float heightRatio = h / yMax;
    return y + h - tbl.data.get(i).values.get(0) * heightRatio;
  }
  
  void makeDataVizs() {
    float yMax = super.getAxisMax(0);
    for (int i = 0; i < this.tbl.data.size(); i++) {
      //PShape dot = createShape(ELLIPSE, getPtX(i), getPtY(i, yMax), PTRADIUS * 2, PTRADIUS * 2);
      PShape marker = makeMarker(getPtX(i), getPtY(i, yMax), MRK_WIDTH, MRK_WIDTH);
      DataViz dataViz = new DataViz(this.tbl.data.get(i), marker);
      this.dvs.add(dataViz);
    }
  }
  
  void drawEmbellishments(float opacity) {
    super.drawEmbellishments(opacity);
    
    float yMax = super.getAxisMax(0);
    for (int i = 0; i < tbl.data.size() - 1; i++) {
      float x1 = getPtX(i), y1 = getPtY(i, yMax);
      float x2 = getPtX(i+1), y2 = getPtY(i+1, yMax);
      line(x1, y1, x2, y2);
    }
  }
  
  PShape makeMarker(float x, float y, float w, float h) {
    PShape marker = createShape();
    marker.beginShape();
    marker.fill(255);
    marker.vertex(x, y - h/2);
    marker.vertex(x + w/2, y);
    marker.vertex(x, y + h/2);
    marker.vertex(x - w/2, y);    
    marker.endShape(CLOSE);
    return marker; 
  }
}