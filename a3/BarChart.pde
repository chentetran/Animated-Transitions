class BarChart extends AxisChart {
  BarChart(DataTable tbl, float x, float y, float w, float h, color on, color off) {
    super(tbl, x, y, w, h, on, off);
  }
  
  void makeDataVizs() {
    float gapSize = this.w / this.tbl.data.size();
    float rectWidth = .8 * gapSize;
    float xStart = this.x + (gapSize - rectWidth) / 2;
    float heightRatio = this.h / super.getAxisMax(0);
    
    for (int i = 0; i < this.tbl.data.size(); i++) {
      float rectHeight = this.tbl.data.get(i).values.get(0) * heightRatio;
      //PShape bar = createShape(RECT, xStart + gapSize * i, y + h - rectHeight, rectWidth, rectHeight);
      PShape bar = makeBar(xStart + gapSize * i, y + h - rectHeight, rectWidth, rectHeight);
      DataViz dataViz = new DataViz(this.tbl.data.get(i), bar);
      this.dvs.add(dataViz);
    }
  }
  
  PShape makeBar(float x, float y, float w, float h) {
    PShape bar = createShape();
    bar.beginShape();
    bar.fill(255);
    bar.vertex(x, y);
    bar.vertex(x + w, y);
    bar.vertex(x + w, y + h);
    bar.vertex(x, y + h);
    bar.endShape(CLOSE);
    return bar;
  }
  
}