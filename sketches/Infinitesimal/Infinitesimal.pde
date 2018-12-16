import java.text.SimpleDateFormat;  
import java.util.Date;  


float n = 1000;
float s = 1;

PGraphics buffer;
float w, h;



//int[] palette = new int[]{ #88498F, #779FA1, #E0CBA8, #FF6542, #564154 };
int[] palette = new int[]{ #7D21FF, #F28B0E, #5E9E0F, #FF0000, #FFFF14 };
int devScale = 4;
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
  w = width;
  h = height;
  buffer = createGraphics(int(w), int(h));
  buffer.beginDraw();
  buffer.noStroke();
  buffer.endDraw();

  noStroke();
  background(255);
  minim = new Minim(this);
  //backgroundSound = minim.loadFile( "background.mp3", 2048);
  //backgroundSound.play();
}

float a = 100;
float angle=0;

void draw() {

  surface.setTitle(String.format("Frames: %d FPS: %.0f n=%.0f", frameCount, frameRate, n));

  float offset = millis()/duration * 200;


  if (frameCount >= duration)
    noLoop();


  if (frameCount< 8 * fpsOut) { //few seconds: blank
    fill(255, 255);
    rect(0, 0, w, h);
    saveFrame("/frames/####.png");
    return;
  }

  angle+= QUARTER_PI/100;


  int fadeOutStart = 55 * fpsOut;
  int fadeOutEnd = 60 * fpsOut;
  if (frameCount >= fadeOutStart) //fadeout 
  {
    resetMatrix();
    fill(255, map(frameCount, fadeOutStart, fadeOutEnd, 1, 255));
    rect(0, 0, w, h);
    saveFrame("/frames/####.png");
    return;
  }

  buffer.beginDraw();
  buffer.translate(w/2, h/2);
  buffer.rotate(angle);
  for (float i = 0; i < n; i++) {
    color c = palette[int(i)%palette.length];
    float x = w/n  * i;
    float y = tan(a*x + a * x*x)  * offset;


    buffer.fill(c, 150);// + abs(y/h)*80);
    s= 2 + 1*pow(abs(y/h), 1.2);
    buffer.ellipse(x+ frameCount/1000, y, s, s);
  }
  buffer.endDraw();
  //translate(noise(millis()/5000.)*10, noise(millis()/5000. + 33432)*10);
  //background(255, 20);
  image(buffer, 0, 0);
  saveFrame("/frames/####.png");
}
