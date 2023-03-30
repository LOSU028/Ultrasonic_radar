#include <Servo.h>
Servo servo;
int Trig = 5;
int Echo = 6;
int p;
int distancia; 
int tiempo;

void setup() {
 //servo.attach(13);
  pinMode(Trig,OUTPUT);
  pinMode(Echo,INPUT); 
  Serial.begin(9600);
}

void loop() {
  Serial.println(p);
  while(Serial.available()){
    p = Serial.read();
    delay(10);
    }
  if ( p == 200){
    servo.attach(13);
  for(int i = 0; i<180;i++){
    servo.write(i);
    delay(20);
    Serial.print(i);
    Serial.print('|');
    distancias();
    Serial.print(distancia);
    Serial.print('.');
    Serial.print("\n");
    delay(10);
    }
     for(int i = 180; i>0;i--){
    servo.write(i);
    delay(20);
    Serial.print(i);
    Serial.print('|');
    distancias();
    Serial.print(distancia);
    Serial.print('.');
    Serial.print("\n");
    delay(10);
    }
  }
  else if ( p == 201){
   servo.detach();
   digitalWrite(Trig,LOW);
   }

}
int distancias(){
  digitalWrite(Trig,LOW); //asegurar que empieza en low 
    delayMicroseconds(2);
    digitalWrite(Trig,HIGH);
    delayMicroseconds(10);
    digitalWrite(Trig,LOW);
     tiempo = pulseIn(Echo,HIGH);
    //debido a que pulseIn regresa el tiempo en microsegundos desde que se mando la onda hasta que el echo la recibio debemos usar ese mismo tiempo para convertirlo en distancia, t = d/v entonces, d = t*v, 
    //velocidad del sonido = .034 cm/ms.
    distancia = (tiempo/2)*0.034;
  
  }
