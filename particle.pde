class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  
  float genRate;
  float resistance;
  float scale;
  float minSize;
  
  float age;
  float dt;
  float size;
  int alive;
  
  float shade;
  float hue;
  
  Particle(float x, float y, float z) {
    this.pos = new PVector(x, y, z);
    this.vel = new PVector(0, 0, 0);
    this.acc = new PVector(0, 0, 0);
    
    this.genRate = random(0.1, 0.2);
    this.resistance = random(0.8, 0.95);
    this.scale = random(1, 2); //user can adjust it
    this.minSize = random(1, 15);
    this.age=0;
    this.alive=1;
    this.size=10;
    
    this.shade = random(100, 255);
    this.hue = random(startHue, endHue);
  }
  
  void update(float dt){
    this.age+=dt;
    this.size-=0.05;
    
    this.acc.add(new PVector(0, this.genRate, 0));
    
    // Generate noise value by the particle's position.
    float n = noise((frameCount*noiseSpeed*2+this.pos.x)*noiseScale, 
                    (frameCount*noiseSpeed+this.pos.y)*noiseScale, 
                    (frameCount*noiseSpeed+this.pos.z)*noiseScale);
    
    ////velocity
    //PVector v = new PVector(1,0,0);
    //v.rotate(map(n,0,1,0,TAU));
    //this.vel.add(v.mult(dt));
    
    // Add air drag if it exceeds the threshold.
    if (n > 0.5) {
      this.vel.mult(0.9);
    }
    
    // Move it.
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    translate(this.pos.x, this.pos.y, this.pos.z);
    
    // Scale it to get squash and stretch effect.
    //float sx = max(0.5, 3-this.vel.mag()*0.5);
    //float sy = max(0.5, this.vel.mag()*0.75);
    //scale(sx, sy, sx);
        
  }
  
}
