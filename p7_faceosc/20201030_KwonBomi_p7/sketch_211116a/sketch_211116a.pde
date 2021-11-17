//
// a bar graph for overall smiliness
//
// derived from the FaceOSCReceiver demo

import oscP5.*;
OscP5 oscP5;

int found;
float smileThreshold = 16;
float mouthWidth, previousMouthWidth;
float alpha;
PFont font;
float[] Pointx;
float[] Pointy;
int n;

void setup() {
  size(800,800);
  frameRate(30);
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  n=0;
  background(255);
  noFill();
  stroke(0,50);
  circle(400,400,500);
  colorMode(HSB,400);
  Pointx=new float[10000];
  Pointy=new float[10000];
}

void draw() {  
  alpha=random(TWO_PI);
  if (found > 0) {
    noStroke();
    //fill(mouthWidth > smileThreshold ? color(255, 0, 0) : 0);
    float drawWidth = map(mouthWidth, 10, 25, 0, width);
    Pointx[n]=400+cos(alpha)*drawWidth*1.7;
    Pointy[n]=400+sin(alpha)*drawWidth*1.7;
    
    if(n>4){
      if(Pointx[n]>150&Pointx[n]<650&Pointy[n]>150&Pointy[n]<650){
        //stroke(random(185,260),300,drawWidth*25);
        stroke(64,400,random(250,340));

        beginShape();
        vertex(400,400);
        //bezier(Pointx[n-2],Pointy[n-2],Pointx[n-1],Pointy[n-1],Pointx[n],Pointy[n],Pointx[n+1],Pointy[n+1]);
        quadraticVertex(Pointx[n-4],Pointy[n-4],Pointx[n-3],Pointy[n-3]);
        endShape();
        push();
        circle(400,400,50);
        circle(400,400,150);
       pop();
      }
      else{
        //stroke(0,50);
        stroke(64,400,random(350,400));

        beginShape();
        vertex(400,400);
        //bezier(Pointx[n-2],Pointy[n-2],Pointx[n-1],Pointy[n-1],Pointx[n],Pointy[n],Pointx[n+1],Pointy[n+1]);
        quadraticVertex(Pointx[n-4],Pointy[n-4],Pointx[n-3],Pointy[n-3]);
        endShape();
        push();
        circle(400,400,500);
        circle(400,400,600);
       pop();
      }
      //stroke(0,50);


    }
    ////stroke(random(185,260),300,showWidth*20);
    //line(400,400,400+cos(alpha)*showWidth*1.7,400+sin(alpha)*showWidth*1.7);
    ////stroke(random(300,70),300,showWidth*20);
    //line(400,400,400+cos(alpha)*showWidth*1.7,400+sin(alpha)*showWidth*1.7);

    //stroke(0,50);
    //rect(0, 0, drawWidth, 64,50);
    //text(nf(mouthWidth, 0, 1), drawWidth + 10, 0);

    previousMouthWidth = mouthWidth;
    n++;
  }
}

public void found(int i) {
  found = i;
}

public void mouthWidthReceived(float w) {
  mouthWidth = w;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
  }
}
