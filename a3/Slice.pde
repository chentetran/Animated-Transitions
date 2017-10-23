class Slice extends Visual {
  Slice(DataPoint _pt, float _x, float _y, float _r, float _a1, float _a2, color _on, color _off) {
    super(_pt, _x, _y, _on, _off);
    r = _r;
    a1 = _a1;
    a2 = _a2;
    makeShape();
  }
  
  void makeShape() {
    setColor();
    shape = createShape(ARC, x, y, r*2, r*2, a1, a2, PIE);
  }
  
  boolean isOver() {
    boolean inCircle = pow(mouseX - x, 2) + pow(mouseY - y, 2) <= pow(r, 2);
    float mouseRad = atan2(mouseY - y, mouseX - x);
    mouseRad += mouseRad > 0 ? 0 : 2 * PI;
    return inCircle && mouseRad > a1 && mouseRad < a2;
  }
  
  private void toPoly(Visual vert, int i, int n, float chordLen, float sx1, float sy1, float sx2, float sy2) {
    int aN = int(0.6 * n); // shrink arc
    int bN = n - aN; // unbend line
    if (i < aN) {
      shape = createShape(GROUP);
      shape.addChild(createShape(LINE, x, y, sx1, sy1));
      shape.addChild(createShape(LINE, x, y, sx2, sy2));
      float tR = r * (aN - i) / (float)aN;
      shape.addChild(createShape(ARC, x, y, tR*2, tR*2, a1, a2, PIE));
    } else {
      i -= aN;
      shape = createShape(GROUP);
      float xc = sx1 + (sx2 - sx1) / 2, yc = sy1 + (sy2 - sy1) / 2; // chord center
      float ratio = i / (float)bN;
      float xt = x + (xc - x) * ratio, yt = y + (yc - y) * ratio; // transition
      shape.addChild(createShape(LINE, sx1, sy1, xt, yt));
      shape.addChild(createShape(LINE, sx2, sy2, xt, yt));
    }
  }
  
  void toBar(Visual bar, int i, int n) {
    setColor();
    int pN = int(0.5 * n); // to polygon
    int mN = int(0.3 * n); // move cbords
    int bN = n - pN - mN; // line to bar
    float chordLen = 2 * r * sin((a2 - a1) / 2);
    float sx1 = x + cos(a1) * r, sy1 = y + sin(a1) * r; // slice 1
    float sx2 = x + cos(a2) * r, sy2 = y + sin(a2) * r; // slice 2
    if (i <= pN) {
      toPoly(bar, i, pN, chordLen, sx1, sy1, sx2, sy2);
    } else if (i - pN <= mN) {
      i -= pN;
      float x1 = bar.x + bar.w/2, y1 = bar.y + (bar.h-chordLen)/2; // line pt1
      float x2 = bar.x + bar.w/2, y2 = bar.y + (bar.h+chordLen)/2; // line pt2
      float ratio = (mN - i) / (float)mN;
      if (sy1 <= sy2) {
        shape = createShape(LINE, x1 + (sx1 - x1) * ratio, y1 + (sy1 - y1) * ratio,
                                  x2 + (sx2 - x2) * ratio, y2 + (sy2 - y2) * ratio);
      } else {
        shape = createShape(LINE, x1 + (sx2 - x1) * ratio, y1 + (sy2 - y1) * ratio,
                                  x2 + (sx1 - x2) * ratio, y2 + (sy1 - y2) * ratio);
      }
    } else {
      i -= pN + mN;
      float bW = bar.w * i / (float)bN;
      float bH = bar.h - (bar.h - chordLen) * (bN - i) / (float)bN;
      shape = createShape(RECT, bar.x + (bar.w - bW) / 2, bar.y + (bar.h - bH) / 2, bW, bH);
    }
  }
  
  void toMarker(Visual marker, int i, int n) {
    setColor();
    int pN = int(0.5 * n); // to polygon
    int mN = int(0.3 * n); // move chords
    int lN = int(0.1 * n); // expand line
    int rN = n - pN - mN - lN; // remove line
    float chordLen = 2 * r * sin((a2 - a1) / 2);
    float sx1 = x + cos(a1) * r, sy1 = y + sin(a1) * r; // slice 1
    float sx2 = x + cos(a2) * r, sy2 = y + sin(a2) * r; // slice 2
    if (i <= pN) {
      toPoly(marker, i, pN, chordLen, sx1, sy1, sx2, sy2);
    } else if (i - pN <= mN) {
      i -= pN;
      float x1 = marker.x + marker.w/2, y1 = marker.y + (marker.h-chordLen)/2; // line pt1
      float x2 = marker.x + marker.w/2, y2 = marker.y + (marker.h+chordLen)/2; // line pt2
      float ratio = (mN - i) / (float)mN;
      if (sy1 <= sy2) {
        shape = createShape(LINE, x1 + (sx1 - x1) * ratio, y1 + (sy1 - y1) * ratio,
                                  x2 + (sx2 - x2) * ratio, y2 + (sy2 - y2) * ratio);
      } else {
        shape = createShape(LINE, x1 + (sx2 - x1) * ratio, y1 + (sy2 - y1) * ratio,
                                  x2 + (sx1 - x2) * ratio, y2 + (sy1 - y2) * ratio);
      }
    } else if (i - pN - mN <= lN) {
      i -= pN + mN;
      float lH = marker.h - (marker.h - chordLen) * (lN - i) / (float)lN;
      shape = createShape(LINE, marker.x, marker.y + (marker.h - lH) / 2, 
                                marker.x, marker.y + (marker.h + lH) / 2);
    } else {
      i -= pN + mN + lN;
      shape = createShape(GROUP);
      float ratio = (rN - i) / (float)rN;
      shape.addChild(createShape(LINE, marker.x, marker.y, marker.x, marker.y + marker.h * ratio));
      float tR = marker.r * (1 - ratio);
      shape.addChild(createShape(ELLIPSE, marker.x, marker.y, tR*2, tR*2));
    }
  }
  
  void toSlice(Visual slice, int i, int n) {
    makeShape();
  }
}