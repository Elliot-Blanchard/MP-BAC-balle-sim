float x =0.0;
float y = 0.0;

float x1=0.0;
float y1=0.0;

float x2=0.0;
float y2=0.0;

float y_pos=1;
float y_pos1=0;

float angle = 0.0;
float angle1 = 0.0;
float angle2 = 0.0;

float xs = 0;
float ys = 0;

float xu = 0;
float speedxu = -5;


void setup () {
  size (1200,700);
    background(0);
}

void draw () {
  smooth ();
  background(0);

ellipse(750,400,150,150);
ellipse( 30,30,300,300);

  
angle = angle+PI/50;

  x = 100 + 170* cos(angle);
  y = 100 + 220* sin(angle);
  ellipse(x+650,y+300,40,40);
  
angle1 = angle1+PI/30;

 x1 = 100 + 100* cos(angle1);
 y1 = 100 + 100* sin(angle1);
 ellipse(x1+650,y1+300,30,30);
 
 angle2 = angle2+PI/70;

 x2 = 100 + 360* cos(angle2);
 y2 = 100 + 160* sin(angle2);
 ellipse(x2+650,y2+300,60,60);
 
 ellipse(xs+500,ys+0,50,50);
 xs=xs-5;
 ys=ys+10;
 if (ys>height){
   ys = 0;
   xs= 0 ;
 }
 
 ellipse (xu+995,100,50,50);
 ellipse (xu+1055,100,50,50);
 ellipse (xu+1025,50,100,90);
 ellipse (xu+1025,90,150,30); 

xu = xu + speedxu;
if (xu == -400){
  speedxu = speedxu * -1;
}
if (xu == 0){
  speedxu = speedxu * -1;}
   
 rect(1100,550,50,50);
}