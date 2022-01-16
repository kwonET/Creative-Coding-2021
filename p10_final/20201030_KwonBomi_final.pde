/*
Mud slide 3d

Particles fall and are slown down by air drag that is being driven from a noise field.

This was very much inspired by this gif done by Raven Kwok 
https://78.media.tumblr.com/1c96a858b448116aec9a5de38bc983e0/tumblr_ongyyg2dP51t2eg65o5_400.gif

Watch another test I rendered out with more particles:
http://jasonlabbe3d.com/resources/videos/processing/mudslide_processing.mp4

Controls:
  - Click to change the hue.
  - Move the mouse to rotate the camera.

Author:
  Jason Labbe

Site:
  jasonlabbe3d.com
*/

//Sam Nosenzo - Node, Root class
//https://openprocessing.org/sketch/413719

import oscP5.*;
import netP5.*;
import processing.video.*;

OscP5 oscP5;
NetAddress dest;

Node nn;
ArrayList<Node> nodes;
ArrayList<Root> roots;

int spawnCount = 4;

float startHue;
float endHue;

float noiseScale = 0.006;
float noiseSpeed = 3;
float lastTime = 0;
int motionsize=15;
float motionrotate=width/2;
float ML_Out = 0; 
Capture cam;
int capture=0;
int Cnt=0;
int adding;
int n=30;
color c;
PImage img;
PShape globe;


int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;
int ColorMode=-1;
// Randomly picks a range the hue can lerp with.
void assignHue() {
  startHue = random(255);
  
  float hueRange = 40;
  
  if (startHue+hueRange > 255) {
    endHue = startHue-hueRange;
  } else {
    endHue = startHue+hueRange;
  }
}


void setup() {
  size(displayWidth, displayHeight, P3D);
  
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6448);

  
  String[] cameras = Capture.list();
  // The camera can be initialized directly using an element
  // from the array returned by list():
  cam = new Capture(this, cameras[0]);
  // Or, the settings can be defined based on the text in the list
  //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
  
  // Start capturing the images from the camera
  cam.start();
  
  rectMode(CENTER);
  //colorMode(HSB, 255);
  colorMode(HSB, 360, 100, 100, 100);
  noiseDetail(1);
  // precalculate 1 period of the sine wave (360 degrees)
  
  nodes=new ArrayList<Node>();
  nn = new Node(random(-800,800),-height/3,random(-800,800),30);
 
  roots=new ArrayList<Root>();
  img=loadImage("3.gif");
  globe = createShape(SPHERE, 120); 
  globe.setTexture(cam);
  noStroke();
  
  assignHue();
  adding=1;
  b1=color(#15120e);
  b2=color(#d2b48c);
}


void draw() {
  fill(255,10);
  noStroke();
  rect(0, 0, width, height);
  stroke(255);//255
  //setGradient(0, 0, width, height, b1, b2, Y_AXIS);
//= [rgb(#15120e),'#695a46','#d2b48c'];
  background(0);
  
  //pushMatrix();
  //translate(nn.loc.x,-height/3,0);
  //texture(cam);
  //lights();
  //sphere(112);
  //popMatrix();
  
   //The following does the same as the above image() line, but 
   //is faster when just drawing the image without any additional 
   //resizing, transformations, or tint.
  ////set(0, 0, cam);
  
  //push();
  //  picture();
  //pop();
  
  // Transform camera into place.
  scale(0.95);
  translate(width/2-200, height*0.5, -300);
  //translate(width/2, height*0.25, -400);
  rotateY(radians(80));
  rotateZ(radians(-25));
  rotateY(radians(map(mouseX, 0, width, -90, 90)));
  rotateZ(radians(map(mouseY, 0, height, -50, 50)));

  
  nn.display();
  nn.nodedisplay();
  print(nodes.size()," ");
  for(int i = 0; i < nodes.size(); i++){
   Node ns = nodes.get(i);
   Root r = roots.get(i);
   //display the nodes as circles, I chose not to display default-ly
   ns.display();
   if(dist(r.loc.x, r.loc.y, r.loc.z,r.targ.x, r.targ.y,r.targ.z) > 20){
      if(random(1) > .5){
        //if the distance is greater than a certain amount the root has the chance to create offshoots
        //5% of the time
        r.createOffshoot();
      }
   }
   //operate and display roots
  if(ColorMode==1){
    float angle = r.loc.heading();    
    float hue = map(sin(angle), -1, 1, 0, 90);
    float saturation=map(cos(angle),-1,1,70,100);
    float brightness = map(i, 0, r.size, 1, 100);
    c = color(hue,saturation,brightness,100);
  }
  else if (ColorMode==-1){
     c=color(0,0,100,50);
  }
   r.update(c);
   r.display(c);
  }
  
  //Cnt is increasing, n is bigger, then roots gets more slowly.
  if(Cnt%n==0) create();
  Cnt+=1;
}


// automatically called whenever osc message is received
void oscEvent(OscMessage m) {
  m.print();

  // message from wekinator to processing
  if (m.checkAddrPattern("/output_1")==true) {
      motionsize+=7;

  }
  if (m.checkAddrPattern("/output_2")==true) {
      motionsize+=7;
  }
  if (m.checkAddrPattern("/output_3")==true) {
    for(int i=0;i<20;i++)  n+=10;
  }
  if (m.checkAddrPattern("/output_4")==true) {
     for(int i=0;i<20;i++)  n-=10;
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

void create() {
  assignHue();
  
    //add node and root each time 
    Node ns = new Node(random(-800,800),0,random(-800,800),80);
    nodes.add(ns);
    
    //The angle makes sure the root is coming out of the side of the main node that is facing the new node
    float angle = PVector.sub(ns.loc, nn.loc).heading();
    Root r = new Root(nn.loc.x+.2*nn.size*cos(angle), nn.loc.y+.2*nn.size*sin(angle), nn.loc.z+.2*nn.size*sin(angle),motionsize, ns.loc);
    //Root r = new Root(nn.loc.x, nn.loc.y, nn.loc.z,random(10, 15), ns.loc);
  
    roots.add(r);
  
}

void mousePressed() {
  assignHue();
  ColorMode=-ColorMode;
}
