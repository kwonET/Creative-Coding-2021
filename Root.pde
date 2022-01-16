class Root{
  
  //initialization of variable
  PVector loc, vel, acc;
  
  //stores the path. was going to do something with this
  //could just run a while loop and have it appear at once
  //but I like watching it grow
  ArrayList<PVector> path;
  
  //This list allows the roots to have smaller offshoots of the same object essentially
  ArrayList<Root> offshoots;
  PVector targ;
  
  //start of the noise function
  float nx = random(200000); 
  
  //current size and initial size are stored
  float size, initSize;
  float maxspeed = 3;
  float maxforce = 2;
  float id;
  float noisestart;
  
  float shade;
  float hue;
  int r,g,b;
  
  Root(float x, float y, float z, float sz, PVector tgt){
    loc = new PVector(x, y, z);
    vel = new PVector(0,0,0);
    acc = new PVector(0,0,0);
    size = sz;
    targ = tgt.get();
    initSize = sz;
    path = new ArrayList<PVector>();
    offshoots = new ArrayList<Root>();
    this.shade = random(100, 255);
    this.hue = random(startHue, endHue);
    
    //randomizes the noise function a bit more
    noisestart = random(0, TWO_PI);
    
    //initial distance from point
    id = dist(loc.x, loc.y,loc.z, targ.x, targ.y, targ.z);
  }
  
  void update(color c){
    //always seeks the target if the distance from it is less than 10
    if(dist(loc.x, loc.y, loc.z,targ.x, targ.y,targ.z) > 10){
      seek(targ);
    }
    
    //physics stuff
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    //path.add(loc);
    acc.mult(0);
    
  
  }
  
  void display(color c){
    //display offshoots (if any)
    for(Root r: offshoots){
      //only display if they are more than 5 pixels away
     if(dist(r.loc.x, r.loc.y, r.loc.z, r.targ.x, r.targ.y, r.targ.z) > 5 ){
      r.update(c);
      r.display(c);
     }
    }
    
    //display main root  
    strokeWeight(size);
          
    //loc.y -> -400~-100
      //stroke(253,187,45); 
      //stroke(178,31,31); 
      //stroke(26,42,108);
    //color c=color(253,187,45);
    //color c1=color(253,187,45);
    //color c2=color(178,31,31);
    //color c3=color(26,42,108);
    
    //float y = random(width);
    //float x = random(height);
    //float adj = map(x, height, 253,187,45);
    //float adj2 = map(y, width,178,31,31);
    //float adj3 = map(x, height, 26,42,108);
    //c = color(adj3, adj, adj2);
    
    //if(loc.y<-200) c=color(random(253,178),random(187,31),random(45,31));
    //else if (loc.y<150) c=color(random(178,26),random(31,42),random(31,108));
    //else c=c3;
    stroke(c,50);
    point(loc.x, loc.y,loc.z);
  }
  
  
  void applyForce(PVector force){
    acc.add(force);
  }
    
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, loc);
    
    //store current distance
    float d = desired.mag();
    
    //map size of the root to the distance
    size = map(d, 0, id, 0, initSize);
    desired.normalize();
    desired.mult(maxspeed); //scale vector to maxspeed;
    
    //get current direction of target
    float angle = target.heading();
    
    //add noise to the angle
    angle+=map(noise(nx), 0, 1, -noisestart, TWO_PI-noisestart);
    PVector steer = PVector.sub(desired, vel); //Reynolds formula for steering force
    //create force vector from the noise angle and give it a little strength
    PVector offset = PVector.fromAngle(angle);
    offset.mult(3);
    //add the noise vector to the original steering vector
    steer.add(offset);
    steer.limit(maxforce);
    
    applyForce(steer); //apply the force as the object acceleration
    nx+=.5;
  }
  
  void createOffshoot(){
     //adds an offshoot to the root
    Root r = new Root(loc.x, loc.y, loc.z, size*.9, new PVector(loc.x+random(-5, 5), loc.y+random(-5, 5),loc.z+random(-5, 5)));
    offshoots.add(r);
  }
}
