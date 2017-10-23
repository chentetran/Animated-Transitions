static final color DISABLED = #E0E0E0;

interface ButtonCallback {
  void callback();
}

class Button {
  float x, y, w, h;
  String text;
  color on, off;
  ButtonCallback buttonCallback;
  private color c;
  private boolean enabled = true;
  
  Button(float _x, float _y, float _w, float _h, String _text, color _on, color _off, ButtonCallback _buttonCallback) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    text = _text;
    on = _on;
    off = _off;
    buttonCallback = _buttonCallback;
    c = off;
  }
  
  boolean isOver() {
    return mouseX >= x && mouseX <= x + w &&
           mouseY >= y && mouseY <= y + h;
  }
  
  void setEnability(boolean enability) {
    enabled = enability;
  }
  
  void onClick() {
    if (enabled) {
      buttonCallback.callback();  
    }
  }
  
  void onOver() {
    if (enabled) c = on;
  }
  
  void onOff() {
    c = off;
  }
  
  void draw() {
    if (enabled) fill(c);
    else fill(DISABLED);
    rect(x, y, w, h);
    fill(0);
    float tWid = textWidth(text);
    text(text, x + (w - tWid) / 2, y + h / 2);
  }
}