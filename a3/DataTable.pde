import java.util.Arrays;

class DataPoint{
  String label;
  ArrayList<Float> values;
  
  DataPoint(String label, ArrayList<Float> values) {
    this.label = label;
    this.values = new ArrayList<Float>(values);
  }
}

class DataTable {
  ArrayList<String> headers;
  ArrayList<DataPoint> data;
  
  float getAxisSum(int i) {
    float total = 0;
    for (DataPoint pt : data) total += pt.values.get(i);
    return total;
  }
  
  float getAxisMax(int i) {
    float hi = data.get(0).values.get(i);
    for (DataPoint pt : data) hi = max(pt.values.get(i), hi);
    return hi;
  }
  
  float getAxisMin(int i) {
    float min = data.get(0).values.get(i);
    for (DataPoint pt : data) min = min(pt.values.get(i), min);
    return min;
  }
  
  DataTable(String fname) {
    String[] lines = loadStrings(fname);
    String[] headers = split(lines[0], ",");
    this.headers = new ArrayList<String>(Arrays.asList(headers));
    this.data = new ArrayList<DataPoint>();
    
    for (int i = 1; i < lines.length; i++) {
      String[] line = split(lines[i], ",");
      ArrayList<Float> values = new ArrayList<Float>();
      for (int j = 1; j < line.length; j++) {
        values.add(Float.valueOf(line[j]));
      }
      data.add(new DataPoint(line[0], values));
    }
  }
}