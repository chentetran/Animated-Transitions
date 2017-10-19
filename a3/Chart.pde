final int GAPS = 10;

abstract class Chart {
  DataTable tbl;
  float x, y, w, h;
  color on, off;
  protected ArrayList<DataViz> dvs;
  private color c;
  
  Chart(DataTable tbl, float x, float y, float w, float h, color on, color off) {
    this.tbl = tbl;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.on = on;
    this.off = off;
    this.dvs = new ArrayList<DataViz>();
    this.c = off;
  }
  
  float getAxisMax(int i) {
    float hi = 0;
    for (DataPoint pt : this.tbl.data) hi = max(hi, pt.values.get(i));
    return hi;
  }
  
  abstract void makeDataVizs();
  abstract void drawEmbellishments();
  abstract void drawData();
}

class BarChart extends Chart {
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
      PShape bar = createShape(RECT, xStart + gapSize * i, y + h - rectHeight, rectWidth, rectHeight);
      DataViz dataViz = new DataViz(this.tbl.data.get(i), bar);
      this.dvs.add(dataViz);
    }
  }
  
  void drawEmbellishments() {
    float fontH = textAscent() + textDescent();
    fill(0);
    
    // axis
    line(this.x, this.y+this.h, this.x+this.w, this.y+this.h);
    line(this.x, this.y, this.x, this.y+this.h);
    
    // axis labels
    text(tbl.headers.get(0), this.x + this.w + 5, this.y + this.h + fontH/2 - 3);
    text(tbl.headers.get(1), this.x - textWidth(tbl.headers.get(1)) / 2, this.y - 10); 
    
    // y ticks
    float maxV = super.getAxisMax(0);
    for (int i = 0; i < GAPS+1; i++) {
      float tickY = this.y + this.h * i / GAPS;
      line(this.x-5, tickY, this.x, tickY);
      float tickVal = maxV - (maxV * i / GAPS);
      String tickStr = String.format("%.2f", tickVal);
      text(tickStr, this.x - 10 - textWidth(tickStr), tickY + fontH / 2 - 3);
    }
    
    // x labels
    for (int i = 0; i < this.tbl.data.size(); i++) {
      fill(0);
      float labelX = this.x + ((i + 0.3) * this.w/tbl.data.size());
      float labelY = this.y + this.h + 10; 
      pushMatrix();
      translate(labelX, labelY);
      rotate(PI / 4.0);
      text(this.tbl.data.get(i).label, 0, 0);
      popMatrix();
    }
    
    
    
    
  }
  
  void drawData() {
    for (DataViz viz : dvs) {
      viz.draw();
    }
  }
}