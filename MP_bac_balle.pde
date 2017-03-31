// =#=#=#=#=#=#=#=#VALEURS DE DEPART#=#=#=#=#=#=#=#=

int nObstacles = 50;
int nBalles = 300;
Obstacle[] obstacles = new Obstacle[nObstacles];
ArrayList<Balle> Balles = new ArrayList<Balle>();
//Balle[] balles = new Balle[nBalles];
float friction = 0.9999;
float grav = 0.3;
color b= color(0,0,0);
color c= color(255,255,255);
float vitesseMoyenne = 0;
boolean checkClick = false;
boolean dragging = false;
float dragX;
float dragY;
int closest;
bouton pause = new bouton(0,0,100,50,255,255,255,"PAUSE");
bouton play = new bouton(100,0,100,50,255,255,255,"PLAY");
bouton frame = new bouton(200,0,100,50,255,255,255,"+1F");


// =#=#=#=#=#=#=#=#CLASSE BOUTON (CREATION D'UN MENU BASIQUE)#=#=#=#=#=#=#=#=

class bouton{
  float posX,posY,l,h; 
  color couleur;
  String texte = "";
  bouton(float x, float y, float L, float H, float r, float g ,float b, String t){
    posX = x; posY = y; l = L; h = H;
    couleur = color(r,g,b);
    texte = t;
  }
  
  void afficher(){
    fill(couleur);
    rect(posX,posY,l,h);
    fill(0);
    textSize(20);
    text(texte,posX + 10,posY + 10, l-20,h-20);
  }
  void checkClick(){
   if (mouseX >= posX && mouseX <= posX + l && mouseY >= posY && mouseY <= posY + h){
     if (texte == "PAUSE"){noLoop();}
     if (texte == "PLAY") {loop();}
     if (texte == "+1F") {redraw();}
     checkClick = true;
   }
  }
}

// =#=#=#=#=#=#=#=#CLASSE BALLE (OBJETS DYNAMIQUES)#=#=#=#=#=#=#=#=

class Balle{
  boolean Ylock = false;
  float posX;float posY;float vitX;float vitY;float vitesse;float angle;float rayon;float coeffRebond; int id;
  Balle(float Xpos, float Ypos, float Xvit, float Yvit, float vit, float ang,float radius, float cr, int idinput){
    posX = Xpos; posY = Ypos; vitX = Xvit; vitY = Yvit; vitesse = vit; angle = ang;rayon = radius;coeffRebond = cr; id = idinput;
  }  
  void update(){
    
    // _-_-_-_-_-_-_-_-_-_-MOUVEMENT-_-_-_-_-_-_-_-_-_-_
    
    posX += vitX;
    posY += vitY;
    vitY += grav;
    vitesse = sqrt(sq(vitX) + sq(vitY));
    angle = degrees(atan2(vitY, vitX));
    
    // _-_-_-_-_-_-_-_-_-_-REBOND CONTRE LES BORDS DE L'ECRAN-_-_-_-_-_-_-_-_-_-_
    
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
    
    // _-_-_-_-_-_-_-_-_-_-REBOND CONTRE LES OBSTACLES-_-_-_-_-_-_-_-_-_-_
    
    for ( int i = 0; i < nObstacles; i++){
      if (sqrt(sq(posX - obstacles[i].posX) + sq(posY - obstacles[i].posY)) < obstacles[i].R + rayon){
        angle = degrees(atan2(posY - obstacles[i].posY, posX - obstacles[i].posX));
        if (vitesse < 0.2){
          vitesse = 0;
        }
        vitesse *= coeffRebond;
      }
    }
    
    // _-_-_-_-_-_-_-_-_-_-REBOND ENTRE BALLES-_-_-_-_-_-_-_-_-_-_
    
    for ( int i = 0; i < nBalles; i++) {
      Balle B = Balles.get(i);
      if (id != B.id){
        if (sqrt(sq(posX -B.posX) + sq(posY - B.posY)) < B.rayon + rayon){
            angle = degrees(atan2(posY - B.posY, posX - B.posX));
            vitesseMoyenne = (vitesse + B.vitesse)/2; 
           vitesse = vitesseMoyenne * coeffRebond;
           B.angle = degrees(atan2(B.posY - posY, B.posX - posX));
           if (vitesse < 0.2 && B.vitesse == 0){
          vitesse = 0;
           B.vitesse = 0;
          
        }
        else{B.vitesse = vitesseMoyenne * B.coeffRebond;}
        }
      }
    }
    
    // _-_-_-_-_-_-_-_-_-_-APPLICATION DES NOUVELLES VALEURS-_-_-_-_-_-_-_-_-_-_
    
    vitesse *= friction;
    vitX = (cos(radians(angle))) * vitesse;
    vitY = (sin(radians(angle))) * vitesse;
    
    // _-_-_-_-_-_-_-_-_-_-REPLACEMENT DES BALLES SORTIES DE L'ECRAN-_-_-_-_-_-_-_-_-_-_
    
    if (posX > width || posY > height || posX < 0 || posY < 0){
    posX = int(random(100,width - 100));
    posY = int(random(100,height-100));
    }
}
}

// =#=#=#=#=#=#=#=#CLASSE OBSTACLE (OBJETS STATIQUES)#=#=#=#=#=#=#=#=

class Obstacle{
  float posX; float posY; float taille; float R;
  Obstacle (float Xpos,float Ypos,float Taille){
    posX = Xpos; posY = Ypos; taille = Taille; R = taille/2;
  }
}

// =#=#=#=#=#=#=#=#CREATION DE LA FENETRE DE DEPART#=#=#=#=#=#=#=#=

void setup(){
    size(1000,700);
  for ( int i = 0; i < nObstacles; i++){
   obstacles[i] = new Obstacle(int(random(100,width - 100)),int(random(100,height-100)) ,30 + int(random(-10,10)));
  }
  for ( int i = 0; i < nBalles; i++) {
   Balles.add(new Balle(int(random(100,width - 100)),int(random(100,height - 100)),int(random(-10,10)),int(random(-10,10)),0,25,int(random(5,10)),random(0.8,0.9), i));
  }
  surface.setResizable(true);
  frameRate(60);
}

// =#=#=#=#=#=#=#=#FONCTIONS ASSOCIEES A DES TOUCHES#=#=#=#=#=#=#=#=

void keyPressed(){
  if (key == 'r' || key == 'R'){
    for ( int i = 0; i < nBalles; i++) {
      Balles.remove(0);
    }
   for ( int i = 0; i < nBalles; i++) {
   Balles.add(new Balle(int(random(100,width - 100)),int(random(100,height - 100)),int(random(-10,10)),int(random(-10,10)),0,25,int(random(5,10)),random(0.8,0.9), i));
    }
  
    for ( int i = 0; i < nObstacles; i++){
   obstacles[i] = new Obstacle(int(random(100,width - 100)),int(random(100,height-100)) ,30 + int(random(-10,10)));
   }
   redraw();
  }
  if (key == 'o' || key == 'O'){
    for ( int i = 0; i < nObstacles; i++){
   obstacles[i] = new Obstacle(int(random(100,width - 100)),int(random(100,height-100)) ,30 + int(random(-10,10)));
   }
   redraw();
  }
  if (key == 'b' || key == 'B'){
    for ( int i = 0; i < nBalles; i++) {
      Balles.remove(0);
    }
    for ( int i = 0; i < nBalles; i++) {
   Balles.add(new Balle(int(random(100,width - 100)),int(random(100,height - 100)),int(random(-10,10)),int(random(-10,10)),0,25,int(random(5,10)),random(0.8,0.9), i));
    }
    redraw();
  }
  }
  
void mousePressed(){
  pause.checkClick();
  play.checkClick();
  frame.checkClick();
  if (mouseButton == LEFT){
    if (checkClick == false){
      dragging = true;
      dragX = mouseX; dragY = mouseY;
    }
  }
  else if (mouseButton == RIGHT){
    closest = 10;
    for ( int i = 0; i < nBalles; i++) {
    Balle B = Balles.get(i);
    if (sqrt(sq(mouseX - B.posX)+sq(mouseY - B.posY)) < closest){
      closest = i;
    }
    }
    Balles.remove(closest);
    nBalles --;
  }
  checkClick = false;
  
}
void mouseReleased(){
 if (dragging == true){
   dragging = false;
   nBalles ++;
   Balles.add(new Balle(dragX,dragY,(dragX - mouseX)/5,(dragY - mouseY)/5,0,180,int(random(5,10)),random(0.8,0.9), nBalles));
 }
}
// =#=#=#=#=#=#=#=#BOUCLE DRAW(FAIT FONCTIONNER LE PROGRAMME)#=#=#=#=#=#=#=#=  
  
void draw(){
  background(b);
  fill(c);
  stroke(c);
  for ( int i = 0; i < nBalles; i++) {
   Balle B = Balles.get(i);
  ellipse(B.posX, B.posY, B.rayon * 2,B.rayon * 2);
  B.update();
  }
  fill(124);
  stroke(124);
  for ( int i = 0; i < nObstacles; i++){
  ellipse(obstacles[i].posX,obstacles[i].posY,obstacles[i].taille, obstacles[i].taille);
  }
  if (dragging == true){line(dragX,dragY,mouseX,mouseY);}
  pause.afficher();
  play.afficher();
  frame.afficher();
}