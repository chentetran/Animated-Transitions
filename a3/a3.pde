Chart chart = null;
BarChart bchart = null;
LineChart lchart = null;
final Transitions transitions = new Transitions();
final int TNUM = 80;

int i = 0;
ArrayList<PShape> tFrames;

void setup() {
  size(1024, 768);
  File f = new File("/home/charlw/Comp/comp177/a3/a3/data.csv");
  //File f = new File("/Users/vincenttran/Desktop/Animated-Transitions/a3/data.csv");
  parseData(f);
  //selectInput("Choose file to parse", "parseData");
  //tFrames = transitions.barsToMarkers(bchart.dvs, lchart.dvs, TNUM);
  tFrames = transitions.markersToBars(lchart.dvs, bchart.dvs, TNUM);
}



void draw() {
  background(255);
  if (i < tFrames.size()-1) {
    transitions.lineToBar(lchart, bchart, i, TNUM);
    shape(tFrames.get(i));
    i++;
  } else {
    transitions.lineToBar(lchart, bchart, TNUM, TNUM);
    shape(tFrames.get(tFrames.size()-1));
  }
  //if (chart != null) {
  //  chart.drawEmbellishments(0.5);
  //  chart.drawData();
  //}
  
  //drawButtons();
}

void drawButtons() {
  float startingX = width / 6.0;
  float startingY = height / 6.0;
  color clickable = color(#add8e6);
  color unclickable = color(#808080);
  Button convertToBarChart = new Button(startingX, startingY, 100.0, 100.0, "Bar Chart", clickable, unclickable, null);
  Button convertToLineChart = new Button(startingX, startingY, 100.0, 100, "Line Chart", clickable, unclickable, null);
  Button convertToPieChart = new Button(startingX, startingY, 100.0, 100.0, "Pie Chart", clickable, unclickable, null);
  convertToBarChart.draw();
  convertToLineChart.draw();
  convertToPieChart.draw();
  
}

void parseData(File f) {
  DataTable tbl = new DataTable(f.getAbsolutePath());
  bchart = new BarChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  bchart.makeDataVizs();
  lchart = new LineChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  lchart.makeDataVizs();
  chart = bchart;
}