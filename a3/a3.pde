Chart chart = null;
DataTable tbl;
final Transitions transitions = new Transitions();

int i = 0;
ArrayList<ArrayList<PShape>> tFrames;

void setup() {
  size(1024, 768);
  //File f = new File("/home/charlw/Comp/comp177/a3/a3/data.csv");
  File f = new File("/Users/vincenttran/Desktop/Animated-Transitions/a3/data.csv");
  parseData(f);
  //selectInput("Choose file to parse", "parseData");
  Chart lineChart = new LineChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  lineChart.makeDataVizs();
  Chart barChart = new BarChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  barChart.makeDataVizs();
  tFrames = new ArrayList<ArrayList<PShape>>();
  for (int i = 0; i < barChart.dvs.size(); i++) {
    PShape bar = barChart.dvs.get(i).shape;
    PShape marker = lineChart.dvs.get(i).shape;
    tFrames.add(transitions.barToLine(bar, marker, 50));
  }
}



void draw() {
  background(255);
  if (i < tFrames.get(0).size()-1) {
    for (ArrayList<PShape> frames : tFrames) shape(frames.get(i));
    i++;
  } else {
    for (ArrayList<PShape> frames : tFrames) shape(frames.get(frames.size()-1));
  }
  //if (chart != null) {
  //  chart.drawEmbellishments();
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
  tbl = new DataTable(f.getAbsolutePath());
  chart = new BarChart(tbl, 0.2*width, 0.2*height, 0.6*width, 0.6*height, color(0, 0, 0), color(255, 255, 255));
  chart.makeDataVizs();
}