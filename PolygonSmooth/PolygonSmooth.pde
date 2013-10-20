import toxi.color.*;
import toxi.geom.*;
import toxi.processing.*;
import java.util.*;

int num=300;
PImage src;

List<ColoredPolygon> polygons = new ArrayList<ColoredPolygon>();

ToxiclibsSupport gfx;

void setup() {
  src = loadImage("http://img.ffffound.com/static-data/assets/6/cdefc106cacd1cb982c8d19c19acb383b0a44713_m.jpg");
  background(255);
  size(1920, 1080);
  gfx = new ToxiclibsSupport(this);
}

void draw() {
  noFill();

  strokeWeight(1);
  for (int i = 0; i < 10; i++) {
    for (ColoredPolygon p : polygons) {
      stroke(p.col, 30);
      p.smooth(0.01, 0.0516);
      gfx.polygon2D(p);
    }
  }
}

void mousePressed() {
  //filter(BLUR,2);
  polygons.clear();
  int col = src.get(floor(random(src.width)), floor(random(src.height)));
  //TColor col = ColorRange.BRIGHT.getColor().setAlpha(random(0.5, 0.8));
  // add randomized vertices
  ColoredPolygon poly=new ColoredPolygon(col);
  float radius=random(800, 1000);
  float n = random(1000);
  for (int i=0; i<num; i++) {
    n += 0.02;
    poly.add(Vec2D.fromTheta((float) i / num * TWO_PI).scaleSelf(noise(n) * radius).addSelf(mouseX, mouseY));
  }
  polygons.add(poly);
}

class ColoredPolygon extends Polygon2D {
  int col;
  public ColoredPolygon(int col) {
    this.col=col;
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    this.save("data/output/composition-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".tif");
    this.save("/Users/criebsch/Dropbox/Public/p5/composition-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png");
  }
    if (key == ' ') {
    polygons.clear();
  }
}

