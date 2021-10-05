void setup(){
    size(540,860);
   // background(222, 209, 197);
   
    background(0);
    frameRate(5);
    draw();
}
void draw(){
    float centerx = random(0,540);
    float centery = random(0,860);
    float degree = 0;
    float delta = random(HALF_PI,PI*1.5);
    

    if(centerx<220 || centerx>320){

        float minus_radius=3;
        int num=1;
        int alpha_=40;
        while(num<12){
 
            while(degree<delta){
                float radius = random(30,35);
                stroke(44,25,12,alpha_);
                line(centerx, centery, centerx + minus_radius*radius*cos(degree)*0.85, centery + minus_radius*radius*sin(degree)*0.85);
                stroke(250,243,239,alpha_);
                line(centerx + minus_radius*radius*cos(degree)*0.85, centery + minus_radius*radius*sin(degree)*0.85, centerx + minus_radius*radius*cos(degree), centery + minus_radius*radius*sin(degree));
                degree+=PI/180;
            }
            degree = delta;
            delta += random(HALF_PI,PI*1.5);
            minus_radius-=0.25;
            num+=1;
            alpha_+=5;
        }
    }


    else{

        int num=1;
        float minus_radius=1.5;
        int alpha_=40;
        while(num<6){
            while(degree<delta){
                float radius = random(30,35);
                stroke(44,25,12,alpha_);
                line(centerx, centery, centerx + minus_radius*radius*cos(degree)*0.85, centery + minus_radius*radius*sin(degree)*0.85);
                stroke(250,243,239,alpha_);
                line(centerx + minus_radius*radius*cos(degree)*0.85, centery + minus_radius*radius*sin(degree)*0.85, centerx + minus_radius*radius*cos(degree), centery + minus_radius*radius*sin(degree));
                degree+=PI/180;
            }
            degree = delta;
            delta += random(HALF_PI,PI*1.5);
            minus_radius-=0.25;
            num+=1;
            alpha_+=10;
        }
    }
}

    void mouseClicked(){
     background(222, 209, 197);
    }
