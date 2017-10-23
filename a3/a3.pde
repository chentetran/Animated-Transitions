DataTable tbl = null;
Chart chart = null;
BarChart bchart = null;
LineChart lchart = null;
PieChart pchart = null;
Button lastClicked = null;
final int AXIS = 0;

int i = 0;
final int TFRAMES = 200;
Chart target = null;

final color BTN_ON = #64B5F6;
final color BTN_OFF = #BBDEFB;
ArrayList<Button> btns = new ArrayList<Button>(); // bar, line, pie

class ToBarChart implements ButtonCallback {
  void callback() { target = bchart; }
}

class ToLineChart implements ButtonCallback {
  void callback() { target = lchart; }
}

class ToPieChart implements ButtonCallback {
  void callback() { target = pchart; }
}

void setup() {
  size(1024, 768);
  
  File f = new File("/Users/vincenttran/Desktop/Animated-Transitions/a3/data.csv");
  parseData(f);
  Button initialSelected = new Button(0.8*width, 0.1*height, 0.1*width, 0.133*height, "Bar Chart", BTN_ON, BTN_OFF, new ToBarChart());
  lastClicked = initialSelected;            // initial chart is bar chart
  btns.add(initialSelected);
  btns.add(new Button(0.8*width, 0.433*height, 0.1*width, 0.133*height, "Line Chart", BTN_ON, BTN_OFF, new ToLineChart()));
  btns.add(new Button(0.8*width, 0.766*height, 0.1*width, 0.133*height, "Pie Chart", BTN_ON, BTN_OFF, new ToPieChart()));
}

void draw() {
  background(255);
  mouseOff();
  mouseOver();
  
  if (chart != null) {
    if (chart != target) {
      transition();
    } else {
      chart.drawEmbellishments();
      chart.drawVisuals();
    }
  }
  for (Button b : btns) {
    if (chart != target || b == lastClicked) {
      b.setEnability(false);     // in transition
    } else {
      b.setEnability(true); 
    }
    
    b.draw();
  }
}



void parseData(File f) {
  tbl = new DataTable(f.getAbsolutePath());
  bchart = new BarChart(tbl, 0.1*width, 0.2*height, 0.6*width, 0.6*height);
  lchart = new LineChart(tbl, 0.1*width, 0.2*height, 0.6*width, 0.6*height);
  pchart = new PieChart(tbl, 0.1*width, 0.2*height, 0.6*width, 0.6*height);
  chart = bchart;
  target = bchart;
}

void transition() {
  if (i > TFRAMES) {
    i = 0;
    chart.makeVisuals(); // reset shapes
    chart = target;
    chart.drawEmbellishments();
    chart.drawVisuals();
    return;
  }
  if (i <= TFRAMES / 2) {
    chart.fadeOut(i, TFRAMES / 2);
    chart.drawEmbellishments();
  } else {
    target.fadeIn(i - TFRAMES / 2, TFRAMES / 2);
    target.drawEmbellishments();
  }
  if (target == bchart) {
    chart.visualsToBars(bchart, i, TFRAMES);
  } else if (target == lchart) {
    chart.visualsToMarkers(lchart, i, TFRAMES);
  } else {
    chart.visualsToSlices(pchart, i, TFRAMES);
  }
  chart.drawVisuals();
  if (i <= TFRAMES) i++;
}

void mouseClicked() {
  for (Button b : btns) {
    if (chart == target && b.isOver()) {
      b.onClick();
      lastClicked = b;
    } 
  }
}

void mouseOver() {
  for (Button b : btns) {
    if (b.isOver()) b.onOver();
  }
}

void mouseOff() {
  for (Button b : btns) {
    if (!b.isOver()) b.onOff();
  }
}