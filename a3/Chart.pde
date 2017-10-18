final int GAPS = 10;

abstract class Chart {
  DataTable tbl;
  float x, y, w, h;
  color on, off;
  private ArrayList<DataViz> dvs;
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
  }
  
  void drawData() {
  }
}
//class BarChart implements Chart {
//  void drawEmbellishments() {
    
//  }
  
//  void drawData() {
    
//  }
//}

//class LineChart implements Chart {
//  void drawEmbellishments() {
    
//  }
    
//  void drawData() {
    
//  }
//}

//class PieChart implements Chart {
//  void drawEmbellishments() {
    
//  }
    
//  void drawData() {
    
//  }
//}