class Transitions {
  ArrayList<PShape> barToLine(PShape begin, PShape end, int n) {
    n -= 2;
    ArrayList<PShape> phases = new ArrayList<PShape>();
    phases.add(begin);
    
    // shrink bar height
    int shrinkN = int(n * 0.85);
    float barHeight = abs(begin.getVertex(2).y - begin.getVertex(1).y);
    float deltaH = barHeight / float(shrinkN - 1);
    
    for (int i = 0; i < shrinkN; i++) {
      PShape transitionShape = copyPShape(begin);
      PVector v2 = transitionShape.getVertex(2);
      PVector v3 = transitionShape.getVertex(3);
      transitionShape.setVertex(2, v2.x, v2.y - deltaH * i);
      transitionShape.setVertex(3, v3.x, v3.y - deltaH * i);
      phases.add(transitionShape);
    }
    
    // change to marker
    int chgN = n - shrinkN;
    float barWidth = abs(begin.getVertex(1).x - begin.getVertex(0).x);
    float markerWidth = abs(end.getVertex(3).x - end.getVertex(1).x);
    float markerHeight = abs(end.getVertex(2).y - end.getVertex(0).y);
    float deltaW = (abs(barWidth - markerWidth) / 2) / (chgN - 1);
    deltaH = (markerHeight / 2) / (chgN - 1);
    float deltaBW = (barWidth / 2) / (chgN - 1);
    PShape flat = copyPShape(phases.get(phases.size()-1));
    
    for (int i = 0; i < chgN; i++) {
      PShape tShp = copyPShape(flat);
      PVector v0 = tShp.getVertex(0), v1 = tShp.getVertex(1), v2 = tShp.getVertex(2), v3 = tShp.getVertex(3);
      tShp.setVertex(0, v0.x + i * deltaBW, v0.y - i * deltaH);
      tShp.setVertex(1, v1.x - i * deltaW, v1.y);
      tShp.setVertex(2, v2.x - i * deltaBW, v2.y + i * deltaH);
      tShp.setVertex(3, v3.x + i * deltaW, v3.y);
      phases.add(tShp);
    }
    
    phases.add(end);
    return phases;
  }
  
  PShape copyPShape(PShape shape) {
    PShape copy = createShape();
    copy.beginShape();
    for (int i = 0; i < shape.getVertexCount(); i++) {
       copy.vertex(shape.getVertex(i).x, shape.getVertex(i).y);
    }
    
    
    copy.endShape(CLOSE);
    return copy;
  }
  
}