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
      //DataViz dataViz = new DataViz(this.tbl.data.get(i), bar);
      DataViz dataViz = new DataViz(this.tbl.data.get(i), xStart + gapSize * i, y + h - rectHeight, rectWidth, rectHeight, Shape.RECTANGLE);
      this.dvs.add(dataViz);
    }
  }
}