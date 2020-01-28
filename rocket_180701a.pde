import processing.serial.*;
PImage cloud;
PImage plane;
int i=900;
int r=600;
int p=0;
int b=0;
int g=0;
int[] serialInArray = new int[2];
int serialCount = 0; 
 boolean firstContact = false; 
boolean st=false;
Serial myPort;
void setup(){
  String portName = "COM3";
    
   myPort = new Serial(this, portName, 9600);
  cloud=loadImage("cl2.jpg");
 plane =loadImage("images.jpg");
  size(900,700);
  //background(255);
}
void draw(){
  float v=map(b,0,20,0,700);
  float h=map(g,0,255,0,7);
 background(255);
  image(cloud,i,0);
  image(cloud,r,200);
  image(plane,200,v);
 // delay(10000);
 i=i-(int)h;
 r=r-(int)h;
 // println(b);
 
 if(i==0){i=900;}
 if(r==0){r=900;}
 //if(p==900){i=0;}
 // }
 
   }
    void serialEvent(Serial myPort) {
    // read a byte from the serial port:
    int inByte = myPort.read();
    // if this is the first byte received, and it's an A, clear the serial
    // buffer and note that you've had first contact from the microcontroller.
    // Otherwise, add the incoming byte to the array:
    if (firstContact == false) {
      if (inByte == 'A') {
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
      }
    }
    else {
      // Add the latest byte from the serial port to array:
      serialInArray[serialCount] = inByte;
      serialCount++;

      // If we have 3 bytes:
      if (serialCount > 1 ) {
        b = serialInArray[0];
        g = serialInArray[1];
       // fgcolor = serialInArray[2];

        // print the values (for debugging purposes only):
        println(b + "\t" + g + "\t" );

        // Send a capital A to request new sensor readings:
        myPort.write('A');
        // Reset serialCount:
        serialCount = 0;
      }
    }
  }