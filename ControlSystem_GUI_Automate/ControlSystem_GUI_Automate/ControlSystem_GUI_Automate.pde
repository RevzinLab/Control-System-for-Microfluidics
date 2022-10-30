// This GUI requires the ControlP5 library
// Before starting, connect Arduino, check COM port and modify line 61 

import controlP5.*;           // import ControlP5 library
import processing.serial.*;

Serial port;

ControlP5 cp5;
PFont font;
PFont font2;
Textlabel statusLabel;
String status = "";
Integer onColor = color(0, 0, 50);
Integer offColor = color(160, 160, 160);
Integer onColorAuto = color(10, 10, 150);
Integer offColorAuto = color(150, 150, 180);
Integer buttonColor = offColor;
Integer buttonSizeX = 200;
Integer buttonSizeY = 75;

// Main function buttons
Button funct0;    // idle
Button funct1;    // manualDegassing
Button funct2;    // pullPlasma
Button funct3;    // fillReagent
Button funct4;    // pushPlasma
Button funct5;    // degassing
Button funct6;    // mixing
Button funct7;    // valves
Button funct8;    // stop

// Total automation
Button automate;   // whole process


void setup(){

  size(550, 620);                           // window size, w,h
  rectMode(CENTER);                         // centers GUI in the screen
  printArray(Serial.list());                // prints all available serial ports
  port = new Serial(this, "COM4", 9600);   // check you own COM port
  
  cp5 = new ControlP5(this);
  font = createFont("arial", 25);           // font for buttons and title
  font2 = createFont("arial",22);
  
  funct0 = cp5.addButton("Idle")            // function name and button text
    .setPosition(50, 100)                   // x,y coordinates of upper left corner of button
    .setSize(buttonSizeX-100, buttonSizeY)  // button w,h
    .setFont(font)
    .setColorBackground(offColor)
  ;
  
  funct1 = cp5.addButton("holdPressure")
    .setPosition(50, 200)
    .setSize(buttonSizeX, buttonSizeY)
    .setFont(font2)
    .setLabel("Hold Pressure")
    .setColorBackground(offColor)
  ;
  
  funct2 = cp5.addButton("pullPlasma")     
    .setPosition(50, 300)
    .setSize(buttonSizeX, buttonSizeY)      
    .setFont(font)
    .setLabel("Pull Plasma")
    .setColorBackground(offColor)
  ;
  
  funct3 = cp5.addButton("fillReagents")     
    .setPosition(50, 400)
    .setSize(buttonSizeX, buttonSizeY)
    .setFont(font2)
    .setLabel("Fill Reagents")
    .setColorBackground(offColor)
  ;
  
  funct4 = cp5.addButton("pushPlasma")     
    .setPosition(300, 200)
    .setSize(buttonSizeX, buttonSizeY)
    .setFont(font)
    .setLabel("Push Plasma")
    .setColorBackground(offColor)
  ;
  
  funct5 = cp5.addButton("Degassing")     
    .setPosition(300, 300)
    .setSize(buttonSizeX, buttonSizeY)
    .setFont(font)
    .setLabel("Degassing")
    .setColorBackground(offColor)
  ;

  funct6 = cp5.addButton("Mixing")     
    .setPosition(300, 400)
    .setSize(buttonSizeX, buttonSizeY)
    .setFont(font)
    .setLabel("Mixing")
    .setColorBackground(offColor)
  ;
  
  funct7 = cp5.addButton("Valves")     
    .setPosition(220, 100)
    .setSize(buttonSizeX-85, buttonSizeY)
    .setFont(font)
    .setLabel("Valves")
    .setColorBackground(offColor)
  ;
  
  funct8 = cp5.addButton("Stop")     
    .setPosition(400, 100)
    .setSize(buttonSizeX-100, buttonSizeY)
    .setFont(font)
    .setLabel("Stop")
    .setColorBackground(offColor)
  ;
  
  automate = cp5.addButton("Automate")
    .setPosition(170, 500)
    .setSize(buttonSizeX, buttonSizeY)
    .setFont(font)
    .setLabel("Automate")
    .setColorBackground(offColorAuto)
  ;
  
}


void draw(){
  background(220, 220, 220);                        // background color (r, g, b)
  fill(0, 0, 100);                                  // text color
  textFont(font,33);
  text("Blood Analysis Control System ", 50, 60);  // text, x,y coordinates
}


void Idle(){
  buttonColor = onColor;
  port.write(0);
  printStatus();
  funct0.setColorBackground(onColor);
  funct1.setColorBackground(offColor);
  funct2.setColorBackground(offColor);
  funct3.setColorBackground(offColor);
  funct4.setColorBackground(offColor);
  funct5.setColorBackground(offColor);
  funct6.setColorBackground(offColor);
  funct7.setColorBackground(offColor);
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void holdPressure(){
  port.write(1);
  printStatus();
  funct0.setColorBackground(offColor);
  funct1.setColorBackground(onColor);
  funct2.setColorBackground(offColor);
  funct3.setColorBackground(offColor);
  funct4.setColorBackground(offColor);
  funct5.setColorBackground(offColor);
  funct6.setColorBackground(offColor);
  funct7.setColorBackground(offColor);
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void pullPlasma(){
  port.write(2);
  printStatus();
  funct0.setColorBackground(offColor);
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(onColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void fillReagent(){
  port.write(3);
  printStatus();
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(onColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void pushPlasma(){
  port.write(4);
  printStatus();
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(onColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void Degassing(){
  port.write(5);
  printStatus();
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(onColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void Mixing(){
  port.write(6);
  printStatus();
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(onColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void Valves(){
  port.write(7);
  printStatus();
  funct0.setColorBackground(offColor);
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(onColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(offColorAuto);
}

void Stop(){
  port.write(8);
  printStatus();
  funct0.setColorBackground(offColor); 
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(onColor);
  automate.setColorBackground(offColorAuto);
}

void Automate(){
  port.write(9);
  printStatus();
  funct0.setColorBackground(offColor); 
  funct1.setColorBackground(offColor); 
  funct2.setColorBackground(offColor); 
  funct3.setColorBackground(offColor); 
  funct4.setColorBackground(offColor); 
  funct5.setColorBackground(offColor); 
  funct6.setColorBackground(offColor); 
  funct7.setColorBackground(offColor); 
  funct8.setColorBackground(offColor);
  automate.setColorBackground(onColorAuto);
}


void printStatus(){
  delay(50);
  status = port.readString();
  println(status);
  status = "";
}
