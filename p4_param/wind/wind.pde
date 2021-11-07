int n=6400; //the number of particles
PVector[] ps = new PVector[n];
PVector v;
float f0,f1;
int f0_param=1;
int f1_param=1;
int a=0;
int s=2;
import controlP5.*;
ControlP5 cp5;

void setup() {
  size(1080, 700);   
  for (int i=0; i<n; i++) 
    ps[i]= new PVector(random(width), random(height));
  background(0);
  colorMode(RGB);
  
  cp5 = new ControlP5(this); 
  addSliders();
}

void draw() {
  fill(255,10);
  noStroke();
  rect(0, 0, width, height);
  stroke(255);//255
  
  fill(76,81,109,15);
  noStroke();
  rect(851,43,193,180);
  
  //ang_param(0.002);
  //size_param(2);
  ang_param(f0_param);
  size_param(f1_param);
  float f1=0.02*frameCount;
  float f2= 0.008*frameCount;
  for (int i=0; i<n; i++) {
    PVector p= ps[i];
    float ang=(noise( 0.003*p.x , 0.003*p.y + f0))*4*PI; 
    v = new PVector(0.9*cos(ang)+ 0.57*cos(f1), sin(ang));
    p.add(v);
    
    if ( random(1.0)<0.01 ||p.x<0 || p.x>width || p.y<0 || p.y>height)
      ps[i].set(random(width), random(height)); 
      
    float magSq=v.magSq(); //Calculates the magnitude (length) of the vector, squared. (mag+sqrt)
    strokeWeight(s*0.5 + 0.5/(0.004+magSq));
    //stroke(90,102,110);
    //if(p.y<400)
    //  stroke(random(0,30),0,random(255));
    //else if(p.y<800)
      stroke(random(0,170),random(60,190),random(150,255));
    //else
    //  stroke(random(130,240),random(200,255),random(230,255));
    point(p.x, p.y);
  }
  a+=5;
}

void ang_param(float n0){
  f0=0.001*n0*frameCount; //0.002, 
}
void size_param(int n1){
  s=n1;
}

void f0Slider(int val){
  f0_param=val;
}

void f1Slider(int val){
  f1_param=val;
}

void addSliders(){
    cp5.addKnob("f0Slider")//change the direction, shining gets faster 
      .setBroadcast(false)
      .setPosition(920,75)
      .setRadius(50)
      .setRange(1,20)
      .setValue(f0_param)
      .setLabel("direction, speed")
      .setBroadcast(true)
      ;    
      
    //cp5.addToggle("f1Slider")
    //  .setPosition(635,185)
    //  .setSize(20,20)
    //  .setBroadcast(false)
    //  .setPosition(300,50)
    // //.setRange(0.01, 0.5)
    //  .setRange(1,20)
    //  .setValue(f1_param)
    //  .setLabel("f1")
    //  .setBroadcast(true)
    //  ;
 
    //cp5.addSlider("f0Slider")//the direction
    // .setBroadcast(false)
    // .setPosition(100,50)
    // //.setRange(0.01, 0.5)
    // .setRange(1,20)
    // .setValue(f0_param)
    // .setLabel("f0")
    // .setSliderMode(Slider.FLEXIBLE)
    // .setBroadcast(true)
    // ;
   cp5.addSlider("f1Slider")//the frequency of shinig point
     .setSize(20,140)
     .setBroadcast(false)
     .setPosition(875,55)
     //.setRange(0.01, 0.5)
     .setRange(1,6)
     .setValue(f1_param)
     .setLabel("weight")
     .setSliderMode(Slider.FLEXIBLE)
     .setBroadcast(true)
     ;
}
