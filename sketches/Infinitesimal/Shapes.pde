class Shapes {
  ArrayList<TinyShape> SHAPES;

  int currShapeIx = 0;
  int N_SHAPES = 3;

  color noFillColor = color(200, 0); //color
  color strokeColor = color(200, 0, 0);

  PGraphics g;
  PImage texture;
  Shapes(PGraphics target) {
    this.g=target;
    this.texture = loadImage("texture.png");
    this.texture.loadPixels();
    PVector v0 = new PVector(0, 0.06);

    SHAPES = new ArrayList<TinyShape>();


    for (float i = 0; i<50; i++) {
      float s =  1.5 * (i/20.);
      PShape s1 = createShape(ELLIPSE, int(random(g.width)), int(random(g.height)), s, s);
      TinyShape ts1 = new TinyShape(this.g, s1, new PVector(s, s), v0.copy().mult(s));
      SHAPES.add(ts1);
    }
  }




  void setStroke(color c) {
    this.strokeColor = c;
  }


  void draw() {
    for ( TinyShape ts : SHAPES) {

      for (int i = 0; i < N_SHAPES; i++) {

        g.pushMatrix();
        ts.strokeColor = texture.get(int(ts.pos.x), int(ts.pos.y));
        ts.draw();
        g.popMatrix();
      }
      ts.update();
    }
  }
}
