public enum Shape {
  RECTANGLE, CIRCLE, TRIANGLE, SLICE 
}

class DataViz {
  DataPoint pt;
  //PShape shape;
  float x, y, h, w;
  Shape shape;
  
  //DataViz(DataPoint pt, PShape shape) {
  //  this.pt 
  //  this.shape = shape;
  //}
  
  DataViz(DataPoint pt, float x, float y, float w, float h, Shape shape) {
    this.pt = pt; 
    this.shape = shape;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void draw() {
    //shape(this.shape);
    fill(256);
    switch (shape) {
      case RECTANGLE:
        rect(x, y, w, h);
        break;
      
      case CIRCLE:
        ellipse(x, y, w, h);
        break;
        
      default:
      
    }
  } 
 
}