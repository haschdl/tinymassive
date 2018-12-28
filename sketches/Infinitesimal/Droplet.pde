class Droplet {
  PVector pos ;
  PGraphics g;
  float end;
  float size = 1;
  boolean dropped = false;
  AudioSample dropSound;

  Droplet(PGraphics target, PVector pos0, AudioSample dropSound) {
    this.pos = pos0; 
    g = target;
    end = random(0.5, 0.8) * target.height;
    this.dropSound = dropSound;
  }

  void update() {
    if (pos.y < end)
      pos.y += .1;
  }

  int white = color(255, 255, 255);

  void draw() {
    if (pos.y > end) {
      if (!dropped) {
        //drop1.setGain(pos.y/g.height);
        dropSound.setPan((1-2.*pos.x/g.width)); //pan is [-1,1]
        dropSound.trigger();
      }
      g.stroke(255, 255-10*size);
      g.noFill();
      g.ellipse(pos.x, pos.y, size, size);
      size+=1;
      dropped=true;
    } else {
      //1 pixel
      g.set(int(pos.x), int(pos.y), white);
      //g.rect(pos.x, pos.y, 1, 1);
    }
  }
}
