final float BLFACT = 0.6;

class Transitions {
  private PShape copyPShape(PShape shape) {
    PShape copy = createShape();
    copy.beginShape();
    for (int i = 0; i < shape.getVertexCount(); i++) copy.vertex(shape.getVertex(i).x, shape.getVertex(i).y);
    copy.endShape(CLOSE);
    return copy;
  }
  
  private ArrayList<PShape> groupFrames(ArrayList<ArrayList<PShape>> allFrames, int n) {
    ArrayList<PShape> frames = new ArrayList<PShape>();
    for (int i = 0; i < n; i++) {
      PShape frame = createShape(GROUP);
      for (int j = 0; j < allFrames.size(); j++) frame.addChild(allFrames.get(j).get(i));
      frames.add(frame);
    }
    return frames;
  }
  
  void barToLine(BarChart bchart, LineChart lchart, int i, int n) {
    float fctr = n * BLFACT;
    if (i <= fctr) {
      bchart.drawEmbellishments((fctr - i) / fctr);
    } else {
      lchart.drawEmbellishments((i - fctr) / (n - fctr));
    }
  }
  
  ArrayList<PShape> barsToMarkers(ArrayList<DataViz> bars, ArrayList<DataViz> markers, int n) {
    ArrayList<ArrayList<PShape>> allPhases = new ArrayList<ArrayList<PShape>>();
    for (int i = 0; i < bars.size(); i++) allPhases.add(barToMarker(bars.get(i).shape, markers.get(i).shape, n));
    return groupFrames(allPhases, n);
  }
  
  private ArrayList<PShape> barToMarker(PShape begin, PShape end, int n) {
    n -= 2;
    ArrayList<PShape> phases = new ArrayList<PShape>();
    phases.add(begin);
    
    // shrink bar height
    int shrinkN = int(n * BLFACT);
    float barHeight = abs(begin.getVertex(2).y - begin.getVertex(1).y);
    float deltaH = barHeight / float(shrinkN - 1);
    
    for (int i = 0; i < shrinkN; i++) {
      PShape transitionShape = copyPShape(begin);
      PVector v2 = transitionShape.getVertex(2), v3 = transitionShape.getVertex(3);
      transitionShape.setFill(255);
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
      tShp.setFill(255);
      tShp.setVertex(0, v0.x + i * deltaBW, v0.y - i * deltaH);
      tShp.setVertex(1, v1.x - i * deltaW, v1.y);
      tShp.setVertex(2, v2.x - i * deltaBW, v2.y + i * deltaH);
      tShp.setVertex(3, v3.x + i * deltaW, v3.y);
      phases.add(tShp);
    }
    
    phases.add(end);
    return phases;
  }
  
  void lineToBar(LineChart lchart, BarChart bchart, int i, int n) {
    float fctr = n * BLFACT;
    if (i <= fctr) {
      lchart.drawEmbellishments((fctr - i) / fctr);
    } else {
      bchart.drawEmbellishments((i - fctr) / (n - fctr));
    }
  }
  
  ArrayList<PShape> markersToBars(ArrayList<DataViz> markers, ArrayList<DataViz> bars, int n) {
    ArrayList<ArrayList<PShape>> allPhases = new ArrayList<ArrayList<PShape>>();
    for (int i = 0; i < bars.size(); i++) allPhases.add(markerToBar(markers.get(i).shape, bars.get(i).shape, n));
    return groupFrames(allPhases, n);
  }
  
  private ArrayList<PShape> markerToBar(PShape begin, PShape end, int n) {
    n -= 2;
    ArrayList<PShape> phases = new ArrayList<PShape>();
    phases.add(begin);
   
    int expandN = int(n * 0.85);
    float barHeight = abs(end.getVertex(2).y - end.getVertex(1).y);
   
    // change marker to flat bar
    int chgN = n - expandN;
    float barWidth = abs(end.getVertex(1).x - end.getVertex(0).x);
    float markerWidth = abs(begin.getVertex(3).x - begin.getVertex(1).x);
    float markerHeight = abs(begin.getVertex(2).y - begin.getVertex(0).y);
    float deltaW = (abs(barWidth - markerWidth) / 2) / (chgN - 1);
    float deltaH = (markerHeight / 2) / (chgN - 1);
    float deltaBW = (barWidth / 2) / (chgN - 1);
   
    for (int i = 0; i < chgN; i++) {
      PShape tShp = copyPShape(begin);
      tShp.setFill(255);
      PVector v0 = tShp.getVertex(0), v1 = tShp.getVertex(1), v2 = tShp.getVertex(2), v3 = tShp.getVertex(3);
     
      tShp.setVertex(0, v0.x - i * deltaBW, v0.y + i * deltaH);
      tShp.setVertex(1, v1.x + i * deltaW, v1.y);
      tShp.setVertex(2, v2.x + i * deltaBW, v2.y - i * deltaH);
      tShp.setVertex(3, v3.x - i * deltaW, v3.y);
      phases.add(tShp);
    }
   
    deltaH = barHeight / float(expandN - 1);
    PShape flat = copyPShape(phases.get(phases.size()-1));
    // expand bar
    for (int i = 0; i < expandN; i++) {
      PShape transitionShape = copyPShape(flat);
      transitionShape.setFill(255);
      PVector v2 = transitionShape.getVertex(2);
      PVector v3 = transitionShape.getVertex(3);
      transitionShape.setVertex(2, v2.x, v2.y + deltaH * i);
      transitionShape.setVertex(3, v3.x, v3.y + deltaH * i);
      phases.add(transitionShape);
    }
   
    phases.add(end);
    return phases;
  }
}