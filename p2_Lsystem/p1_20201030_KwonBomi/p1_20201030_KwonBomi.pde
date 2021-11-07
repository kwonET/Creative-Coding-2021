// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
// modified code by Kwon Bomi

LSystem lsys;
Turtle turtle;

void setup() {
  //size(1000,800); 
  size(1200, 1000);
  
  Rule[] ruleset = new Rule[1];
  ruleset[0]=new Rule('F',"FF[FF[---F][+++F][F]][++++FF[---F][+++F][F]][++FF[---F][+++F][F]][--FF[---F][+++F][F]]");
  lsys = new LSystem("F",ruleset);
  turtle = new Turtle(lsys.getSentence(),width/5,radians(43)); //bigger
 //turtle = new Turtle(lsys.getSentence(),width/10,radians(43));  //smaller
} 

void draw() {
  background(0);  
  fill(0);
  //text("Click mouse to generate", 10, height-10);

  //translate(height/2,height/2)
  translate(height/5, height/2);
  //rotate(-PI/2);
  turtle.render();
  noLoop();
}

int counter = 0;

void mousePressed() {
  if (counter < 10) {
    pushMatrix();
    lsys.generate();
    //println(lsys.getSentence());
    turtle.setToDo(lsys.getSentence());
   // turtle.changeLen(1/(1+sqrt(3)));
    turtle.changeLen(0.5);
    popMatrix();
    redraw();
    counter++;
  }
}
