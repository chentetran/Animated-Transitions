class Marker extends Visual {
  Marker(DataPoint _pt, float _x, float _y, float _h, float _r, color _on, color _off) {
    super(_pt, _x, _y, _on, _off);
    h = _h;
    r = _r;
    makeShape();
  }
  
  void makeShape() {
    setColor();
    shape = createShape(ELLIPSE, x, y, r*2, r*2);
  }
  
  boolean isOver() {
    return pow(mouseX - x, 2) + pow(mouseY - y, 2) <= pow(r, 2);
  }
  
  void toBar(Visual bar, int i, int n) {
    setColor();
    int lN = int(0.15 * n); // marker to line
    int sN = n - lN; // line to bar
    float tX = bar.x + (x - (bar.x + bar.w / 2)) * (n - i) / (float)n;
    float tY = bar.y + (y - bar.y) * (n - i) / (float)n;
    if (i < lN) {
      float diffW = bar.w - r * 2;
      float tW = bar.w - diffW * (lN - i) / (float)lN;
      float tH = 2 * r * (lN - i) / (float)lN;
      shape = createShape(ELLIPSE, tX + bar.w / 2, tY, tW, tH);
    } else if (i == lN) {
      shape = createShape(LINE, tX, tY, tX + bar.w, tY);
    } else {
      float tH = bar.h * (i - lN) / (float)sN;
      shape = createShape(RECT, tX, tY, bar.w, tH);
    }
  }
  
  void toMarker(Visual marker, int i, int n) {
    makeShape();
  }
  
  void toSlice(Visual slice, int i, int n) {
    setColor();
    int lN = int(0.1 * n); // marker to line
    int sN = int(0.1 * n); // shrink line
    int mN = int(0.3 * n); // move line
    int bN = int(0.2 * n); // bend line
    int aN = n - lN - sN - mN - bN; // create arc
    float chordLen = 2 * slice.r * sin((slice.a2 - slice.a1) / 2);
    float sx1 = slice.x + cos(slice.a1) * slice.r, sy1 = slice.y + sin(slice.a1) * slice.r; // slice 1
    float sx2 = slice.x + cos(slice.a2) * slice.r, sy2 = slice.y + sin(slice.a2) * slice.r; // slice 2
    if (i < lN) {
      shape = createShape(GROUP);
      float ratio = i / (float)lN;
      shape.addChild(createShape(LINE, x, y, x, y + h * ratio));
      shape.addChild(createShape(ELLIPSE, x, y, r * (1 - ratio) * 2, r * (1 - ratio) * 2));
    } else if (i - lN <= sN) {
      i -= lN;
      float lH = h - (h - chordLen) * i / (float)sN;
      shape = createShape(LINE, x, y + (h - lH) / 2, x, y + (h + lH) / 2);
    } else if (i - sN - lN <= mN) {
      i -= sN + lN;
      float x1 = x + w/2, y1 = y + (h-chordLen)/2, x2 = x + w/2, y2 = y + (h+chordLen)/2; // lines
      float ratio = i / (float)mN;
      if (sy1 <= sy2) {
        shape = createShape(LINE, x1 + (sx1 - x1) * ratio, y1 + (sy1 - y1) * ratio,
                                  x2 + (sx2 - x2) * ratio, y2 + (sy2 - y2) * ratio);
      } else {
        shape = createShape(LINE, x1 + (sx2 - x1) * ratio, y1 + (sy2 - y1) * ratio,
                                  x2 + (sx1 - x2) * ratio, y2 + (sy1 - y2) * ratio);
      }
    } else if (i - mN - sN - lN <= bN) {
      i -= sN + mN + lN;
      shape = createShape(GROUP);
      float xc = sx1 + (sx2 - sx1) / 2, yc = sy1 + (sy2 - sy1) / 2; // chord center
      float ratio = (bN - i) / (float)bN;
      float xt = slice.x + (xc - slice.x) * ratio, yt = slice.y + (yc - slice.y) * ratio; // transition
      shape.addChild(createShape(LINE, sx1, sy1, xt, yt));
      shape.addChild(createShape(LINE, sx2, sy2, xt, yt));
    } else {
      i -= bN + mN + sN + lN;
      shape = createShape(GROUP);
      shape.addChild(createShape(LINE, slice.x, slice.y, sx1, sy1));
      shape.addChild(createShape(LINE, slice.x, slice.y, sx2, sy2));
      float r = slice.r * i / (float)aN;
      shape.addChild(createShape(ARC, slice.x, slice.y, r*2, r*2, slice.a1, slice.a2, PIE));
    }
  }
}