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