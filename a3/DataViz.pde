class DataViz {
  DataPoint pt;
  PShape shape;
  
  DataViz(DataPoint pt, PShape shape) {
    this.pt = pt; 
    this.shape = shape;
  }
  
  void draw() {
    shape(this.shape);
  } 
}