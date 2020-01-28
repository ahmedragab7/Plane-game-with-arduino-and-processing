int ecopin=12;
int trigerpin=13;
int firstSensor = 0;    // first analog sensor
int secondSensor = 0;   // second analog sensor
int thirdSensor = 0;    // digital sensor
int inByte = 0;      
long k,d;
long val;
boolean c=false;
void setup()
{
   Serial.begin(9600);
   while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  establishContact(); 
  pinMode(ecopin,INPUT);
  pinMode(trigerpin,OUTPUT);
 
  analogReference(DEFAULT);
}

void loop()
{
   if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    // read first analog input, divide by 4 to make the range 0-255:
    digitalWrite(trigerpin,LOW);
  delayMicroseconds(2);
  digitalWrite(trigerpin,HIGH);
  delayMicroseconds(10);
  
  digitalWrite(trigerpin,LOW);
  
  k=pulseIn(ecopin,HIGH);
  d=k*0.034/2;
    // delay 10ms to let the ADC recover:
    delay(10);
    // read second analog input, divide by 4 to make the range 0-255:
    secondSensor =  analogRead(4);
    // read switch, map it to 0 or 255L
   // thirdSensor = map(digitalRead(2), 0, 1, 0, 255);
    // send sensor values:
    Serial.write(d);
    Serial.write(secondSensor);
   // Serial.write(thirdSensor);
  }
}
 void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}

              
