float xs = 1200;
float ys = 250;
float xm = 1200;
float ym = 700;
float z = 0;
boolean petit = false;
void setup () {
  size (1200,700);
  
    background(#0A12CB);

}

void draw () {
   smooth ();
   background(#0A12CB);
  ellipse(xs,ys+50,40,40);
  ellipse(xs,ys-50,40,40);
  ellipse(xs+50,ys-28,40,40);
  ellipse(xs+50,ys+28,40,40);
  ellipse(xs,ys,40,40);
 xs=xs-10;
 
 if (xs < 0) {
   xs = 2000;
   petit = true;
 }
 if (petit == true){
   ellipse(xm+80,ys,20,20);
   xm = xm - 50;
   if (xm < 0){
     petit = false;
     xm = 1200;
   }
 }
 ellipse (900,ym,20,20);
 ellipse (940,ym+20,20,20);
 ellipse (890,ym+60,20,20);
 ellipse (895,ym+30,10,10);
 ellipse (920,ym+50,10,10);
 ym=ym-5;
 
 if (ym < -150 ) {
   ym = 700 ;
 }
 
 ellipse (550,700,40,300);
 ellipse (580,700,40,310);
 ellipse (620,700,40,280); 
 ellipse (400,700,40,z);
 z = z+8;
 
if (z >=700){
  z = 0;
 }
   
 
 
}