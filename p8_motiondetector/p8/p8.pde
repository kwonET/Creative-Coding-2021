/** 
 * Gesture Interface Gate Opener
 * Written by Jusub Kim, 2016
 **/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

PImage img;
int gateCnt = 0;
int GATECNT_MAX = 200;
int x=0;
PVector accel;
float xoff=0.0;
float xincrement=0.01;
float h;
int time = 0;
float vel = 0; // TWO_PI / 300 assigned in setup()
int hori_count= 14;
int vert_count = 7;
color[] colors = new color[20];


void setup() {
  size(700, 410, P2D);
  //background(255);


  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("192.168.0.9", 6448);

  //img = loadImage("gateLeft.png");
  accel = new PVector(0, 0, 0);
  
  noFill();
  blendMode(SCREEN);
  vel = TWO_PI / 300;
  
  colors[0] =#F94144;
  colors[1] =#F65A38;
  colors[2] =#F3722C;
  colors[3] =#F68425;
  colors[4] =#F8961E;
  colors[5] =#F9AF37;
  colors[6] =#F9C74F;
  colors[7] =#C5C35E;
  colors[8] =#90BE6D;
  colors[9]=#6AB47C;
  colors[10] =#43AA8B;
  colors[11] =#4D908E;
  colors[12] =#52838F;
  colors[13] =#577590;

}

void draw() {
   background(0, 0, 32,10);
  float n= noise(xoff)*200;
  xoff+=xincrement;
  
  float xw=map(accel.x,-5,5,0,width);
  float yh=map(accel.y,-5,5,0,height);

  if(gateCnt==0){
    //circle(xw+n+random(-200,200),height/2+n, 100);
    for (int y = 0; y < vert_count; y++){
      for (int t = 0; t < hori_count; t++){
          float x_pos = map(sin(time + t / 6 + y / 2), -1, 1, 75, width - 75);
          float y_pos = map(y, 0, vert_count - 1, 50, height - 50);
          stroke(colors[t]);
          //circle(x_pos, y_pos, 35);
          circle(xw+n+random(-200,200),height/2+n, 100);//n+random(-200,200)
          circle(xw-n+random(-200,200),height/2+n-200, 100);//n+random(-200,200)
      }
    }
    time += vel;
  }
  
  if(gateCnt==1){
    //circle(width/2+n,yh+n+random(-200,200),100);
    for (int y = 0; y < vert_count; y++){
      for (int t = 0; t < hori_count; t++){
          float y_pos = map(sin(time + t / 6 + y / 2), -1, 1, 75, width - 75);
          float x_pos = map(y, 0, vert_count - 1, 50, height - 50);  
          stroke(colors[t]);
          //circle(x_pos, y_pos, 35);
          circle(width/2+n+100,yh+random(-200,200)+n,30);
          circle(width/2+n+300,yh+random(-200,200)-n,30);
          circle(width/2+n,yh+random(-200,200)+n,30);
          circle(width/2+n+200,yh+random(-200,200)-n,30);
          circle(width/2+n-100,yh+random(-200,200)+n,30);
          circle(width/2+n-300,yh+random(-200,200)-n,30);
          circle(width/2+n-200,yh+random(-200,200)+n,30);
          circle(width/2+n+50,yh+random(-200,200)-n,30);
      }
    }
    time += vel;
  }
}

// automatically called whenever osc message is received
void oscEvent(OscMessage m) {
  m.print();

  // message from wekinator to processing
  if (m.checkAddrPattern("/output_1")==true) {
      gateCnt = 0;

  }
  if (m.checkAddrPattern("/output_2")==true) {
      gateCnt = 1;
  }
  
//   //message from phone to processing
//  if (m.checkAddrPattern("/oschook")==true) {
//    /* check if the typetag is the right one. */
//    if (m.checkTypetag("ifffffffff")) {
//      /* extract the acceleration values from the osc message */
//      accel.x = m.get(4).floatValue();  
//      accel.y = m.get(5).floatValue();  
//      accel.z = m.get(6).floatValue();  
//      sendOsc();
//    }
//  }
}

//void sendOsc() {
//  OscMessage msg = new OscMessage("/wek/inputs");
//  msg.add(accel.x); 
//  msg.add(accel.y);
//  msg.add(accel.z);
//  oscP5.send(msg, dest);
//}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
