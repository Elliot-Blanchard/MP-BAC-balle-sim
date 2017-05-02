
float x =0.0;
float y = 0.0;

float x1=0.0;
float y1=0.0;

float x2=0.0;
float y2=0.0;

float x3=0.0;
float y3=0.0;

float x4=0.0;
float y4=0.0;

float x5=0.0;
float y5=0.0;

float x6=0.0;
float y6=0.0;

float angle0 = 0.0;
float angle1 = 0.0;
float angle2 = 0.0;
float angle3 = 0.0;
float angle4 = 0.0;
float angle5 = 0.0;
float angle6 = 0.0;

//--------------------

float a =0.0;
float b =0.0;

float a1=0.0;
float b1=0.0;

float a2=0.0;
float b2=0.0;

float a3=0.0;
float b3=0.0;

float a4=0.0;
float b4=0.0;

float a5=0.0;
float b5=0.0;

float a6=0.0;
float b6=0.0;

float ang0 = 0.0;
float ang1 = 0.0;
float ang2 = 0.0;
float ang3 = 0.0;
float ang4 = 0.0;
float ang5 = 0.0;
float ang6 = 0.0;

void setup () {
  size (1200, 700);
  background(80);
}

void draw () {
  smooth ();
  background(80);

  angle0 = angle0+PI/10;

  x = 200 + 50* cos(angle0);
  y = 450 + 20* sin(angle0);
  ellipse(x+200, y+200, 20, 20);

  angle1 = angle1+PI/20;

  x1 = 200 + 100* cos(angle1);
  y1 = 350 + 50* sin(angle1);
  ellipse(x1+200, y1+200, 40, 40);

  angle2 = angle2-PI/35;

  x2 = 200 +130* cos(angle2);
  y2 = 200 + 40* sin(angle2);
  ellipse(x2+200, y2+200, 30, 30);

  angle3 = angle3+PI/15;

  x3 = 200 +100* cos(angle3);
  y3 = 150 + 50* sin(angle3);
  ellipse(x3+200, y3+200, 15, 15);

  angle4 = angle4+PI/30;

  x4 = 200 +200* cos(angle4);
  y4 = 100 + 50* sin(angle4);
  ellipse(x4+200, y4+200, 40, 40);

  angle5 = angle5+PI/50;

  x5 = 200 +250* cos(angle5);
  y5 = 30 + 70* sin(angle5);
  ellipse(x5+200, y5+200, 30, 30);

  angle6 = angle6+PI/20;

  x6 = 200 +100* cos(angle6);
  y6 = -20 + 0* sin(angle6);
  ellipse(x6+200, y6+100, 70, 70);