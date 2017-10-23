class Bar extends Visual {
  Bar(DataPoint _pt, float _x, float _y, float _w, float _h, color _on, color _off) {
    super(_pt, _x, _y, _on, _off);
    w = _w;
    h = _h;
    makeShape();
  }
  
  void makeShape() {
    setColor();
    shape = createShape(RECT, x, y, w, h);
  }
  
  boolean isOver() {
    return mouseX >= x && mouseX <= x + w &&
           mouseY >= y && mouseY <= y + h;
  }
  
  void toBar(Visual bar, int i, int n) {
    makeShape();
  }
  
  void toMarker(Visual marker, int i, int n) {
    setColor();
    int sN = int(0.85 * n); // shrink
    int mN = n - sN; // line to marker
    float tX = x + (marker.x - (x + w / 2)) * (i / (float)n);
    float tY = y + (marker.y - y) * (i / (float)n);
    if (i < sN) {
      float tH = h * (sN - i) / (float)sN;
      shape = createShape(RECT, tX, tY, w, tH);
    } else if (i == sN) {
      shape = createShape(LINE, tX, tY, tX + w, tY);
    } else {
      float diffW = w - marker.r * 2;
      float tW = w - diffW * (i - sN) / (float)mN;
      float tH = 2 * marker.r * (i - sN) / (float)mN;
      shape = createShape(ELLIPSE, tX + w / 2, tY, tW, tH);
    }
  }
  
  void toSlice(Visual slice, int i, int n) {
    setColor();
    int lN = int(0.2 * n); // bar to line
    int mN = int(0.3 * n); // move line
    int bN = int(0.2 * n); // bend line
    int aN = n - lN - mN - bN; // create arc
    float chordLen = 2 * slice.r * sin((slice.a2 - slice.a1) / 2);
    float sx1 = slice.x + cos(slice.a1) * slice.r, sy1 = slice.y + sin(slice.a1) * slice.r; // slice 1
    float sx2 = slice.x + cos(slice.a2) * slice.r, sy2 = slice.y + sin(slice.a2) * slice.r; // slice 2
    if (i < lN) {
      float bW = w * (lN - i) / (float)lN;
      float bH = h - (h - chordLen) * i / (float)lN;
      shape = createShape(RECT, x + (w - bW) / 2, y + (h - bH) / 2, bW, bH);
    } else if (i - lN <= mN) {
      i -= lN;
      float x1 = x + w/2, y1 = y + (h-chordLen)/2, x2 = x + w/2, y2 = y + (h+chordLen)/2; // lines
      float ratio = i / (float)mN;
      if (sy1 <= sy2) {
        shape = createShape(LINE, x1 + (sx1 - x1) * ratio, y1 + (sy1 - y1) * ratio,
                                  x2 + (sx2 - x2) * ratio, y2 + (sy2 - y2) * ratio);
      } else {
        shape = createShape(LINE, x1 + (sx2 - x1) * ratio, y1 + (sy2 - y1) * ratio,
                                  x2 + (sx1 - x2) * ratio, y2 + (sy1 - y2) * ratio);
      }
    } else if (i - mN - lN <= bN) {
      i -= mN + lN;
      shape = createShape(GROUP);
      float xc = sx1 + (sx2 - sx1) / 2, yc = sy1 + (sy2 - sy1) / 2; // chord center
      float ratio = (bN - i) / (float)bN;
      float xt = slice.x + (xc - slice.x) * ratio, yt = slice.y + (yc - slice.y) * ratio; // transition
      shape.addChild(createShape(LINE, sx1, sy1, xt, yt));
      shape.addChild(createShape(LINE, sx2, sy2, xt, yt));
    } else {
      i -= bN + mN + lN;
      shape = createShape(GROUP);
      shape.addChild(createShape(LINE, slice.x, slice.y, sx1, sy1));
      shape.addChild(createShape(LINE, slice.x, slice.y, sx2, sy2));
      float r = slice.r * i / (float)aN;
      shape.addChild(createShape(ARC, slice.x, slice.y, r*2, r*2, slice.a1, slice.a2, PIE));
    }
  }
}