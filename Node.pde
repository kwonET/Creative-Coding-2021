class Node{
  PVector loc;
  boolean centralNode = false;
  float size;
  Node(float x, float y, float z,float sz){
    loc = new PVector(x, y, z);
    size=sz;
  }
  
  void display(){
    push();
    stroke(255);
    noFill();
    strokeWeight(5);
    pop();
    //point(loc.x, loc.y,loc.z); 
  }
  
  void nodedisplay(){
   if (cam.available() == true) {
      cam.read();
    }
    push();
    translate(loc.x,loc.y,loc.z);
    //translate(0,-height/3,0);
    //translate(nn.loc.x,-height/3,0);
    noStroke();
    //lights();
    shape(globe);
    pop();
  }
}
