int nObstacles = 00;
int nBalles = 300;
Obstacle[] obstacles = new Obstacle[nObstacles];
Balle[] balles = new Balle[nBalles];
float friction = 0.9999;
float grav = 0.3;
color b= color(0,0,0);
color c= color(255,255,255);
float vitesseMoyenne = 0;

class Balle{
  boolean Ylock = false;
  float posX;float posY;float vitX;float vitY;float vitesse;float angle;float rayon;float coeffRebond; int id;
  Balle(float Xpos, float Ypos, float Xvit, float Yvit, float vit, float ang,float radius, float cr, int idinput){
    posX = Xpos; posY = Ypos; vitX = Xvit; vitY = Yvit; vitesse = vit; angle = ang;rayon = radius;coeffRebond = cr; id = idinput;
  }  
  void update(){
    
   
    posX += vitX;
    posY += vitY;
    vitY += grav;
    vitesse = sqrt(sq(vitX) + sq(vitY));
    angle = degrees(atan2(vitY, vitX));
    
    if ( posY + vitY >= height-(rayon/2) || posY + vitY <= (rayon/2)){
      vitY = -vitY* coeffRebond;
      vitX = vitX * coeffRebond;
      angle = degrees(atan2(vitY, vitX));
      vitesse *= coeffRebond;
      if (vitesse < 0.2){
          vitesse = 0;
        }
      if (vitY>-5 && posY > height-100){
        vitY = 0;
      }
    }
    
    if (posX + vitX >= width-(rayon/2) || posX + vitX <= (rayon/2)){
      vitX = -vitX*coeffRebond;
      angle = degrees(atan2(vitY, vitX));
      vitesse *= coeffRebond;
      
    }
    for ( int i = 0; i < nObstacles; i++){
      if (sqrt(sq(posX - obstacles[i].posX) + sq(posY - obstacles[i].posY)) < obstacles[i].R + rayon){
        angle = degrees(atan2(posY - obstacles[i].posY, posX - obstacles[i].posX));
        if (vitesse < 0.2){
          vitesse = 0;
        }
        vitesse *= coeffRebond;
      }
    }
    for ( int i = 0; i < nBalles; i++) {
      if (id != balles[i].id){
        if (sqrt(sq(posX - balles[i].posX) + sq(posY - balles[i].posY)) < balles[i].rayon + rayon){
            angle = degrees(atan2(posY - balles[i].posY, posX - balles[i].posX));
            vitesseMoyenne = (vitesse + balles[i].vitesse)/2; 
           vitesse = vitesseMoyenne * coeffRebond;
           balles[i].angle = degrees(atan2(balles[i].posY - posY, balles[i].posX - posX));
           balles[i].vitesse = vitesseMoyenne * balles[i].coeffRebond;
          if (vitesse < 0.2){
          vitesse = 0;
        }
        }
      }
    }
    vitesse *= friction;
    vitX = (cos(radians(angle))) * vitesse;
    vitY = (sin(radians(angle))) * vitesse;
    if (posX > width || posY > height || posX < 0 || posY < 0){
    posX = int(random(100,width - 100));
    posY = int(random(100,height-100));
    }
}
}
class Obstacle{
  float posX; float posY; float taille; float R;
  Obstacle (float Xpos,float Ypos,float Taille){
    posX = Xpos; posY = Ypos; taille = Taille; R = taille/2;
  }
}
void setup(){
    size(1000,700);
  for ( int i = 0; i < nObstacles; i++){
   obstacles[i] = new Obstacle(int(random(100,width - 100)),int(random(100,height-100)) ,30 + int(random(-10,10)));
  }
  for ( int i = 0; i < nBalles; i++) {
   balles[i] = new Balle(int(random(100,width - 100)),int(random(100,height - 100)),int(random(-10,10)),int(random(-10,10)),0,25,int(random(5,10)),random(0.8,0.9), i);
  }
  surface.setResizable(true);
  frameRate(60);
}
void keyPressed(){
  if (key == 'r' || key == 'R'){
    for ( int i = 0; i < nBalles; i++) {
   balles[i] = new Balle(int(random(100,width - 100)),int(random(100,height - 100)),int(random(-10,10)),int(random(-10,10)),0,25,int(random(5,10)),random(0.8,0.9), i);
    }
  
    for ( int i = 0; i < nObstacles; i++){
   obstacles[i] = new Obstacle(int(random(100,width - 100)),int(random(100,height-100)) ,30 + int(random(-10,10)));
   }
  }
  if (key == 'o' || key == 'O'){
    for ( int i = 0; i < nObstacles; i++){
   obstacles[i] = new Obstacle(int(random(100,width - 100)),int(random(100,height-100)) ,30 + int(random(-10,10)));
   }
  }
  if (key == 'b' || key == 'B'){
    for ( int i = 0; i < nBalles; i++) {
   balles[i] = new Balle(int(random(100,width - 100)),int(random(100,height - 100)),int(random(-10,10)),int(random(-10,10)),0,25,int(random(5,10)),random(0.8,0.9), i);
    }
  }
  }
void draw(){
  background(b);
  fill(c);
  stroke(c);
  for ( int i = 0; i < nBalles; i++) {
  ellipse(balles[i].posX, balles[i].posY, balles[i].rayon * 2,balles[i].rayon * 2);
  balles[i].update();
  }
  fill(124);
  stroke(124);
  for ( int i = 0; i < nObstacles; i++){
  ellipse(obstacles[i].posX,obstacles[i].posY,obstacles[i].taille, obstacles[i].taille);
  }
}