//int nObstacles = 50;
int nBalles = 300;
//Obstacle[] obstacles = new Obstacle[nObstacles];
Balle[] balles = new Balle[nBalles];
float friction = 1;
PVector grav;
color b= color(0,0,0);
color c= color(255,255,255);
void setup(){
  size(1000,700);
  for ( int i = 0; i < nBalles; i++) {
   balles[i] = new Balle(random(100,width - 100),random(100,height - 100),random(-5,5),random(-5,5),random(5,10),random(0.99,0.999), i);
  }
  surface.setResizable(true);
  frameRate(60);
  grav = new PVector(0,0.3);
}
class Balle{
  
  PVector pos;
  PVector vit;
  float r,cr,m, id;
  Balle(float x, float y, float vx, float vy, float R, float Cr, float ID){
    pos = new PVector(x,y);
    vit = new PVector(vx,vy);
    r = R;
    cr = Cr;
    m = R*.1;
    id = ID;
  }
  void update(){
    vit.add(grav);
    pos.add(vit);
    vit.mult(friction);
  }
  void CCBord(){
    if (pos.x > width-r) {
      pos.x = width-r;
      vit.x *= -cr;
    } 
    else if (pos.x < r) {
      pos.x = r;
      vit.x *= -cr;
    } 
    else if (pos.y > height-r) {
      pos.y = height-r;
      vit.y *= -cr;
    } 
    else if (pos.y < r) {
      pos.y = r;
      vit.y *= -cr;
    }
  }
  
  void rebondBalle(){
    for ( int i = 0; i < nBalles ; i++){
      if (i!= id){
        
    PVector distance = PVector.sub(balles[i].pos, pos);
    float d = distance.mag();
    if (d < r + balles[i].r) {
      float theta  = distance.heading();
      float sinus = sin(theta);
      float cosinus = cos(theta);
      PVector[] bTemp = {
        new PVector(), new PVector()
        };
      bTemp[1].x  = cosinus * distance.x + sinus * distance.y;
      bTemp[1].y  = cosinus * distance.y - sinus * distance.x;
  
    PVector[] vTemp = {
        new PVector(), new PVector()
        };
      vTemp[0].x  = cosinus * vit.x + sinus * vit.y;
      vTemp[0].y  = cosinus * vit.y - sinus * vit.x;
      vTemp[1].x  = cosinus * balles[i].vit.x + sinus * balles[i].vit.y;
      vTemp[1].y  = cosinus * balles[i].vit.y - sinus * balles[i].vit.x;
      PVector[] vFinal = {  
        new PVector(), new PVector()
        };
        vFinal[0].x = ((m - balles[i].m) * vTemp[0].x + 2 * balles[i].m * vTemp[1].x) / (m + balles[i].m);
      vFinal[0].y = vTemp[0].y;
      vFinal[1].x = ((balles[i].m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + balles[i].m);
      vFinal[1].y = vTemp[1].y;
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;
      PVector[] bFinal = { 
        new PVector(), new PVector()
        };
        bFinal[0].x = cosinus * bTemp[0].x - sinus * bTemp[0].y;
      bFinal[0].y = cosinus * bTemp[0].y + sinus * bTemp[0].x;
      bFinal[1].x = cosinus * bTemp[1].x - sinus * bTemp[1].y;
      bFinal[1].y = cosinus * bTemp[1].y + sinus * bTemp[1].x;
      balles[i].pos.x = pos.x + bFinal[1].x;
      balles[i].pos.y = pos.y + bFinal[1].y;
      pos.add(bFinal[0]);
      vit.x = (cosinus * vFinal[0].x - sinus * vFinal[0].y)* cr;
      vit.y = (cosinus * vFinal[0].y + sinus * vFinal[0].x) * cr;
      balles[i].vit.x = (cosinus * vFinal[1].x - sinus * vFinal[1].y) * balles[i].cr;
      balles[i].vit.y = (cosinus * vFinal[1].y + sinus * vFinal[1].x) * balles[i].cr;
    }
   }
  }  
  }
  
}


void draw(){
  background(b);
  fill(c);
  stroke(125);
  for ( int i = 0; i < nBalles ; i++) {
    ellipse(balles[i].pos.x, balles[i].pos.y, balles[i].r * 2,balles[i].r * 2);
    balles[i].update();
    balles[i].CCBord(); 
    balles[i].rebondBalle();
  }
    
  }

    
    