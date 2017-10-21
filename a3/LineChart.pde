final float PTRADIUS = 5;

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
      PShape dot = createShape(ELLIPSE, getPtX(i), getPtY(i, yMax), PTRADIUS * 2, PTRADIUS * 2);
      //DataViz dataViz = new DataViz(this.tbl.data.get(i), dot);
      DataViz dataViz = new DataViz(this.tbl.data.get(i), getPtX(i), getPtY(i, yMax), PTRADIUS * 2, PTRADIUS * 2, Shape.CIRCLE);
      this.dvs.add(dataViz);
    }
  }
  
  void drawEmbellishments() {
    super.drawEmbellishments();
    
    float yMax = super.getAxisMax(0);
    for (int i = 0; i < tbl.data.size() - 1; i++) {
      float x1 = getPtX(i), y1 = getPtY(i, yMax);
      float x2 = getPtX(i+1), y2 = getPtY(i+1, yMax);
      line(x1, y1, x2, y2);
    }
  }
}