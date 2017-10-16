void setup() {
  size(1024, 768);
  selectInput("Choose file to parse", "parseData");
}

void draw() {
  background(255);
  
  
  drawButtons();
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
}