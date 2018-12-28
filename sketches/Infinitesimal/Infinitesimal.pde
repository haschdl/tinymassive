import java.text.SimpleDateFormat;  
import java.util.Date;  
import ddf.minim.*;
import ddf.minim.effects.*;



PGraphics buffer;
PImage texture;
Shapes shapes;
float w, h;

int[] palette = new int[]{ #7D21FF, #F28B0E, #5E9E0F, #FF0000, #FFFF14 };
int devScale = 3;
float finalW = 77;
float finalH = 13;

int fpsOut = 30;
float duration = 70 * fpsOut; //duration of the animation in FRAMES: 30FPS x 60seconds : 1800


Minim minim;
AudioPlayer backgroundSound;

AudioSample drop1, drop2;

ArrayList<Droplet> droplets = new ArrayList<Droplet>();


void settings() {
  size(int(finalW * devScale), int(finalH * devScale), P2D);
  println("Sketch size: " + width + "x" + height);
}


void setup() {
  w = finalW;
  h = finalH;
  frameRate(fpsOut);
  buffer = createGraphics(int(finalW), int(finalH), P2D);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.endDraw();
  shapes = new Shapes(buffer);


  noStroke();
  background(0);
  minim = new Minim(this);
  backgroundSound = minim.loadFile( "background.mp3", 2048);
  drop1 = minim.loadSample( "drop1_16.wav");
  drop2 = minim.loadSample( "drop2_16.wav");
  texture = loadImage("texture_vol.png");

  for (float i = 0, l = 10; i<l; i++) {
    float x0 = (buffer.width/l) * (i + random(.5)) ;
    float y0 = random(-3, .3)*(buffer.height);
    PVector pos = new PVector(x0, y0);

    droplets.add(new Droplet(buffer, pos, (i%2==0 ? drop1 : drop2 ) ));
  }
}



boolean start = false;
float volume = 0;

void draw() {
  if (!start)
    return;

  surface.setTitle(String.format("t=%.1f, frames: %d FPS: %.0f", millis()/1000., frameCount, frameRate));


  if (frameCount >= duration) {
    noLoop();
    println("Done!");
  }
  buffer.beginDraw();
  buffer.background(0);

  //SCENE 1: Droplets (10 seconds)
  if (frameCount< 15 * fpsOut) { 

    buffer.noStroke();

    for (Droplet d : droplets) {
      d.draw();
      d.update();
    }
    buffer.endDraw();
    save();
    image(buffer, 0, 0, width, height);
  }

  if (frameCount < 5 * fpsOut)
    return;

  //SCENE 2: RAIN (60 seconds)
  if (!backgroundSound.isPlaying()) {
    backgroundSound.play();
    backgroundSound.setGain(-80);
    backgroundSound.shiftGain(-80, 0., 10000);
  }





  buffer.noStroke();
  shapes.draw(constrain((float)1.2*frameCount/duration, 0., 1.));


  //FILLING UP (drawing a line on bottom)

  buffer.resetMatrix();
  buffer.beginShape();
  buffer.textureMode(NORMAL);
  buffer.texture(texture);
  float offset = millis()/1600.;
  for (float i=0; i<=finalW; i++) {
    float x = i; 
    float y =noise(millis()/800.+ i*1122.)*2 + (h-volume); 
    //returns the remainder of the sum, in practice 
    //what it does is to "rotate" the value of u around 0 and 1
    float u= (x/finalW + offset) % 1;
    float v= (y/finalH + offset) % 1;
    buffer.vertex(x, y, u, v);
  }
  buffer.vertex(w, h, 1, offset%1);//botom-right: u,v = 1,1
  buffer.vertex(0, h, 0, offset%1);//botom-left: u,v = 0,1

  buffer.endShape(CLOSE);
  buffer.endDraw();

  //frames left until end
  volume += .007 ;



  image(buffer, 0, 0, width, height);

  int fadeOutStart = 65 * fpsOut;
  int fadeOutEnd = int(duration);
  if (frameCount >= fadeOutStart) //fadeout 
  {
    resetMatrix();
    fill(0, map(frameCount, fadeOutStart, fadeOutEnd, 1, 255));
    rect(0, 0, width, height);
  }

  save();
}

void save() {
  saveFrame("frames/####.png");
}

void keyPressed() {
  if (key=='S' || key=='s') {
    frameCount = 0;
    start = true;
  }
}
