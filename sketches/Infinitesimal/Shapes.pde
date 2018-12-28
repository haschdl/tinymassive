class Shapes {
  ArrayList<TinyShape> SHAPES;

  int[] sizes = new int[] {1, 1, 1, 1, 1, 1, 1, 2, 2, 2};  

  int currShapeIx = 0;


  color noFillColor = color(200, 0); //color
  color strokeColor = color(200, 0, 0);

  PGraphics g;
  PImage texture;
  Shapes(PGraphics target) {
    this.g=target;
    this.texture = loadImage("texture.png");
    this.texture.loadPixels();
    PVector v0 = new PVector(0, random(0.06, 0.12));

    SHAPES = new ArrayList<TinyShape>();


    for (float i = 0; i<50; i++) {
      float s =  sizes[Math.round(random(sizes.length-1))];
      PShape s1 = createShape(ELLIPSE, int(random(g.width)), int(random(g.height)), s, s);
      TinyShape ts1 = new TinyShape(this.g, s1, new PVector(s, s), v0.copy().mult(s));
      SHAPES.add(ts1);
    }
  }




  void setStroke(color c) {
    this.strokeColor = c;
  }


  void draw(float f) {


    //for ( TinyShape ts : SHAPES) {
    for (int i = 0, l = int(f * SHAPES.size()); i<l; i ++) {  
      TinyShape ts = SHAPES.get(i);
      g.pushMatrix();
      ts.strokeColor = texture.get(int(ts.pos.x), int(ts.pos.y));
      ts.draw();
      g.popMatrix();
      ts.update();
    }
  }
}
