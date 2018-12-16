class Shapes {
  ArrayList<TinyShape> SHAPES;

  int currShapeIx = 0;
  int N_SHAPES = 3;

  color noFillColor = color(200, 0); //color
  color strokeColor = color(200, 0, 0);

  PGraphics g;
  Shapes(PGraphics target) {
    this.g=target;
    PVector v0 = new PVector(0, 0.03);

    SHAPES = new ArrayList<TinyShape>();


    for (float i = 0; i<50; i++) {
      float s =  2 * (i/20.);
      PShape s1 = createShape(ELLIPSE, int(random(g.width)), int(random(g.height)),s,s);
      TinyShape ts1 = new TinyShape(this.g, s1, new PVector(0, .3 * i/50.), v0.copy().mult(s));
      SHAPES.add(ts1);
    }
  }




  void setStroke(color c) {
    this.strokeColor = c;
  }


  void draw() {
    for ( TinyShape ts : SHAPES) {
      g.beginDraw();
      for (int i = 0; i < N_SHAPES; i++) {
        g.pushMatrix();

        //ts.noStroke();
        ts.strokeColor = this.strokeColor;
        ts.draw();
        g.popMatrix();
      }

      g.endDraw();
      ts.update();
    }
  }
 
}
