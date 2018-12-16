import java.text.SimpleDateFormat;  
import java.util.Date;  


float n = 20;
float s = 1;

PGraphics buffer;
Shapes shapes;
float w, h;



//int[] palette = new int[]{ #88498F, #779FA1, #E0CBA8, #FF6542, #564154 };
int[] palette = new int[]{ #7D21FF, #F28B0E, #5E9E0F, #FF0000, #FFFF14 };
int devScale = 8;
float finalW = 77;
float finalH = 13;

int fpsOut = 30;
float duration = 60 * fpsOut; //duration of the animation in FRAMES: 30FPS x 60seconds : 1800

import ddf.minim.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer backgroundSound;


void settings() {
  size(int(finalW * devScale), int(finalH * devScale), P2D);
}


void setup() {
  w = finalW;
  h = finalH;
  frameRate(fpsOut);
  buffer = createGraphics(int(finalW), int(finalH));
  buffer.beginDraw();
  buffer.noStroke();
  buffer.endDraw();
  shapes = new Shapes(buffer);
  noStroke();
  background(255);
  minim = new Minim(this);
  backgroundSound = minim.loadFile( "background.mp3", 2048);
}

float a = 100;
float angle=0;
boolean start = false;
float volume = 0;

void draw() {
  if (!start)
    return;

  surface.setTitle(String.format("Frames: %d FPS: %.0f n=%.0f", frameCount, frameRate, n));

  if (frameCount >= duration)
    noLoop();


  if (frameCount< 5 * fpsOut) { //few seconds: blank
    fill(255, 255);
    rect(0, 0, width, height);
    save();
    return;
  }

  angle+= QUARTER_PI/100;


  int fadeOutStart = 57 * fpsOut;
  int fadeOutEnd = 60 * fpsOut;
  if (frameCount >= fadeOutStart) //fadeout 
  {
    resetMatrix();
    fill(255, map(frameCount, fadeOutStart, fadeOutEnd, 1, 255));
    rect(0, 0, width, height);
    save();  
    return;
  }

  buffer.beginDraw();
  buffer.background(255);
  buffer.noStroke();
  shapes.draw();



  //drawing a line on bottom
  buffer.fill(0, 0, 255);
  buffer.resetMatrix();
  //buffer.rect(0, 0, 20, 20);
  buffer.beginShape();


  for (float i=0; i<=finalW; i++) {
    buffer.vertex(i, noise(millis()+ i*1122.)*2 + (h-volume));
  }
  buffer.vertex(w, h);//botom-right
  buffer.vertex(0, h);//botom-left

  buffer.endShape(CLOSE);
  buffer.endDraw();
  image(buffer, 0, 0, width, height);
  save();
  
}

void save() {
  saveFrame("frames/####.png");
}

void keyPressed() {
  if (key=='S' || key=='s') {
    start = true;
    backgroundSound.play();
  }
}
