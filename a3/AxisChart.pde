abstract class AxisChart extends Chart {
   AxisChart(DataTable tbl, float x, float y, float w, float h, color on, color off) {
    super(tbl, x, y, w, h, on, off);
  }
  
  abstract void makeDataVizs();
  
  void drawEmbellishments(float n) {
    float fontH = textAscent() + textDescent();
    stroke((1.0 - n) * 255);
    fill((1.0 - n) * 255);
    
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
      float labelX = this.x + ((i + 0.3) * this.w/tbl.data.size());
      float labelY = this.y + this.h + 10; 
      pushMatrix();
      translate(labelX, labelY);
      rotate(PI / 4.0);
      text(this.tbl.data.get(i).label, 0, 0);
      popMatrix();
    }
  }
  
  void drawEmbellishments(int x, int n) {
      
  }
  
  void drawData() {
    for (DataViz viz : dvs) {
      viz.draw();
    }
  }
}