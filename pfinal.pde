import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
Serial puerto;
int x2 = 50,y2 = 30, largo = 200, ancho = 100, x3 = 750,y3 = 30;
int x, y,o;
float angle,anglep,distancia,pdistancia;
float rx;
float ry;
int diametro;
boolean z,v;
String g,c,n,d,l;
void setup(){
  String nombre = Serial.list()[0];
  puerto = new Serial(this,nombre,9600);
  size(1000,600);
   x= width/2;
   y = height;
   background(0,0,0);
}

void draw(){
  fill(0);
  noStroke();
 rect(x2+250,y2+10,450,48);
  textSize(30); 
 fill(0,0,255);
 text("Angle: ",x2+250,y2+50);
 textSize(20); 
 text(anglep,x2+345,y2+50);
 textSize(30); 
 text("Distance: ",x2+450,y2+50);
 textSize(20); 
  text(distancia,x2+577,y2+50);
  textSize(75);
 onandoff();
 fill(0,0,0);
 text("Start",x2+20,y2+75);
 fill(0,0,0);
 text("Stop",x3+20,y3+75);
 linea();
 detectar();
 radar();
 if(v){
 separar(puerto);
 }
 
}
void radar(){
  //https://processing.org/reference/pushMatrix_.html
  pushMatrix();
  noFill();
  translate(x,y);
  strokeWeight(4);
  stroke(0,0,255);
  line(-x,0,2*x,0);
  for (int i =30; i<151; i+=30){
   angle=i;
   rx = cos(radians(angle));
   ry = sin(radians(angle));
  line(0,0,-x*rx,-x*ry);
  }
  for( int i = 1000; i>249;i-=250){
    diametro = i;
    arc(0,0,diametro,diametro,PI,TWO_PI);
  }
  popMatrix();
}
void onandoff(){
  fill(255,255,255);
  rect(x2,y2,largo,ancho);
  if(mousePressed){
    if(mouseX > x2 && mouseX < x2+largo && mouseY > y2 && mouseY < y2+ancho){
       puerto.write(200);
       v =true;
       
    }
    else{
       puerto.write(201);  
       v = false;
    }
  }
  fill(255,255,255);
  rect(x3,y3,largo,ancho);
  if(mousePressed){
    if(mouseX > x3 && mouseX < x3+largo && mouseY > y3 && mouseY < y3+ancho){
       puerto.write(201);
       v = false;
    }
  }
}
void lineas(){
    
}
void separar(Serial puerto){
  //https://processing.org/reference/String_indexOf_.html
  //https://processing.org/reference/String_substring_.html
  c = puerto.readStringUntil('.');
  if ( c != null){
  c = c.substring(0,c.length()-1);
  o = c.indexOf('|');
  d = c.substring(o+1,c.length());
  distancia = int(d);
  }
  l = puerto.readStringUntil('|');
  if(l!= null){
  l = l.substring(1,l.length()-1);
  anglep = int(l);
  }
  
  
  
  print("Angle: ");
  print(anglep);
  print("\n");
  print("Distance: ");
  print(distancia);
  print("\n");
}
void  linea(){
  pushMatrix();
  translate(x,y);
  stroke(0,88,151);
  line(0,0,x*cos(radians(anglep)),-x*sin(radians(anglep)));
  popMatrix();
  blur();
}
void blur(){
//https://processing.org/reference/fill_.html
//fill(v1,v2,v3,alpha);
  fill(0,0,0,4);
  noStroke();
  ellipse(x, y,width, width); 
}
void detectar(){
  //distancia en pixeles
  pdistancia = distancia*22.5;
  pushMatrix();
  translate(x,y);
  stroke(255,0,0);
  if(distancia<30){
  line(pdistancia*cos(radians(anglep)),-pdistancia*sin(radians(anglep)),x*cos(radians(anglep)),-x*sin(radians(anglep)));
  }
  popMatrix();
}
