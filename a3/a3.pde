void setup() {
  size(1024, 768);
  selectInput("Choose file to parse", "parseData");
}

void draw() {
  background(255);
}

void parseData(File f) {
  DataTable tbl = new DataTable(f.getAbsolutePath());
}