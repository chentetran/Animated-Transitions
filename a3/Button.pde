interface ButtonCallback {
  void buttonCallback();
}

class Button {
  float x,y, w, h;
  String text;
  color on, off;
  ButtonCallback buttonCallback;
  private color c;
  
  Button(float x, float y, float w, float h, String text, color on, color off, ButtonCallback buttonCallback) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.on = on;
    this.off = off;
    this.text = text;
    this.buttonCallback = buttonCallback;
    this.c = this.off;
  }
  
  void onClick() {
    this.buttonCallback.buttonCallback();
  }
  
  void onOver() {
    this.c = this.on;
  }
  
  void onOff() {
    this.c = this.off;
  }
  
  void draw() {
    fill(this.c);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this.text, x + w / 2, y + h / 2);
  }
  
  boolean isOver() {
    return mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h;
  }
}