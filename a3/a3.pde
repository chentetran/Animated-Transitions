Chart chart = null;
BarChart bchart = null;
LineChart lchart = null;
final Transitions transitions = new Transitions();
final int TNUM = 80;

ChartMode chartMode;

ArrayList<Button> buttons;

int i = 0;
ArrayList<PShape> tFrames;

void setup() {
  size(1024, 768);
  //File f = new File("/home/charlw/Comp/comp177/a3/a3/data.csv");
  File f = new File("/Users/vincenttran/Desktop/Animated-Transitions/a3/data.csv");
  parseData(f);
  
  color clickable = color(#add8e6);
  color unclickable = color(#808080);
  float startingX = width - width / 8;
  float startingY = height / 6.0;
  
  buttons = new ArrayList<Button>();
  buttons.add(new Button(startingX, startingY, 100.0, 100, "Line Chart", clickable, unclickable, null));
  buttons.add(new Button(startingX, startingY*2, 100.0, 100, "Bar Chart", clickable, unclickable, null));
  buttons.add(new Button(startingX, startingY*3, 100.0, 100, "Pie Chart", clickable, unclickable, null));
  
  //selectInput("Choose file to parse", "parseData");
}



void draw() {
  background(255);
  drawButtons();
  
  if (tFrames == null) {
     chart.drawData();
     chart.drawEmbellishments(1);
     return;
  }
  
  if (i < tFrames.size()-1) {
    transitionEmbellishments();
    shape(tFrames.get(i));
    i++;
  } else {
    chart.drawEmbellishments(1);
    shape(tFrames.get(tFrames.size()-1));
  }
}

void transitionEmbellishments() {
  switch (chartMode) {
    case Bar:
      transitions.lineToBar(lchart, bchart, i, TNUM);
      break;
    case Line:
      transitions.barToLine(bchart, lchart, i, TNUM);
      break;
    
    default:      // Pie
    
  }
  
}

void drawButtons() {
  for (Button button : buttons) {
    button.draw();  
  }
}

void mouseClicked() {
  for (Button button : buttons) {
    if (mouseX > button.x && mouseX < button.x + button.w && mouseY > button.y && mouseY < button.y + button.h) {
      startTransition(button.text);
      return;
    }
  }
}

void startTransition(String targetChart) {
  i = 0;
  
  switch (targetChart) { 
    case "Line Chart":
      for (int i = 0; i < chart.dvs.size(); i++) {
        tFrames = transitions.barsToMarkers(bchart.dvs, lchart.dvs, TNUM);
        chart = lchart;
        chartMode = ChartMode.Line;
      }
      break;
        
    case "Bar Chart":
      for (int i = 0; i < chart.dvs.size(); i++) {
        tFrames = transitions.markersToBars(lchart.dvs, bchart.dvs, TNUM);
        chart = bchart;
        chartMode = ChartMode.Bar;
      }
      break;
    
    default:
    
  }
}

void parseData(File f) {
  DataTable tbl = new DataTable(f.getAbsolutePath());
  bchart = new BarChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  bchart.makeDataVizs();
  lchart = new LineChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  lchart.makeDataVizs();
  chart = bchart;
  chartMode = ChartMode.Bar;
}

enum ChartMode {
  Bar, Line, Pie 
}