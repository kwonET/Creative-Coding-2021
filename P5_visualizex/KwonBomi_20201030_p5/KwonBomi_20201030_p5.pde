float[] co2=new float[100];
Bubble[][] bubbles;
Table table;
int n;
  
void setup(){
  size(700,1100);
  colorMode(HSB,400);
  background(217,0,390);
  Table table = loadTable("data_.csv","header");
  bubbles=new Bubble[table.getRowCount()][table.getColumnCount()];
  
  for(int i=0;i<table.getRowCount();i++){
    TableRow row = table.getRow(i);
    String n=row.getString(1);
    for(int j=1;j<table.getColumnCount();j++){
      co2[j]=row.getFloat(j);
      bubbles[i][j]=new Bubble(15*i,10*j, co2[j],n,1960+j);
    }
  }
}

void draw(){
  
  randomSeed(1);
  background(217,0,390);
  for (int i = 0; i < bubbles.length; i++) {
     for (int j =1; j < bubbles[i].length; j++) {
      bubbles[i][j].update();
      bubbles[i][j].display();
      bubbles[i][j].rollover(mouseX, mouseY);
   }
  }
  n+=1;
}

class Bubble {
  float x,y;
  float diameter;
  String name;
  boolean over =false;
  int year;
  
  Bubble(float y_, float x_, float diameter_, String s,int year_){
    x=x_;
    y=y_;
    diameter=diameter_;
    name = s;
    year=year_;
  }
  
  void update(){
    
    stroke(216,random(400),random(100,400),100);
    fill(216,random(400),random(150,400),100);
    circle(x+40,y+40,diameter);
  }

  // CHecking if mouse is over the Bubble
  void rollover(float px, float py) {
    float d = dist(px,py,x+40,y+40);
    if (d < diameter/2) {
      over = true; 
    } else {
      over = false;
    }
  }
  
  // Display the Bubble
  void display() {
    if (over) {
      fill(0);
      textAlign(CENTER);
      textSize(10);
      text(name,x+40,y+40+diameter/2+10);
      text(year,x+40,y+50+diameter/2+10);
    }
  }
}
