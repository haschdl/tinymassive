class TinyShape {
  PVector vel = new PVector(.2, .2);
  PVector pos = new PVector();
  PGraphics g;
  PShape s = null;
  float angle = PI / 3;
  color strokeColor = color(255, 255, 255);

  float w = 0;
  float h = 0;
  float scale = 1;


  TinyShape(PGraphics target, PShape innerShape, PVector size, PVector velocity) {
    this.s= innerShape;
    this.g = target;
    this.vel = velocity;
    this.w=size.x;
    this.h=size.y;
  }


  TinyShape update() {
    pos.add(vel);
    if (pos.x >= g.width)
      pos.x=0;

    if (pos.y > g.height) {
      pos.y=0;
      pos.x= int(random(g.width));
      volume+=this.w/100;
    }

    return this;
  }

  void draw() {

    s.setStroke(strokeColor);
    s.setFill(strokeColor);
    g.noStroke();

    g.shape(s, pos.x/scale, pos.y/scale);
  }
}
