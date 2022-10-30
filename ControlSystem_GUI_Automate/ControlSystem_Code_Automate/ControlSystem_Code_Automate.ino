// Initialization

// Variables
float valvePressure = 0;
float flowPressure = 0;
float negativePressure = 0;
float cVoltage = 0;
float fVoltage = 0;
float nVoltage = 0;
unsigned long timing = 0;
unsigned long timeInitial = 0;
unsigned long timeFinal = 0;
float flowTargetPressure = 0;
float valveTargetPressure = 0;
float negativeTargetPressure = 0;
float difference = 0;
float tolerence = 0.02;
bool pump = false;

// Valve solenoids
const int V1 = 24;      // controlValve1
const int V2 = 25;      // controlValve2
const int V3 = 26;      // controlValve3
const int V4 = 27;      // controlValve4
const int V5 = 28;      // controlValve5
const int V6 = 29;      // controlValve6

// Flow solenoids
const int Ve1_Ve3 = 30;
const int Ve2 = 31;

const int I1 = 32;      // flow1
const int I2 = 33;      // flow2
const int I3 = 34;      // flow3
const int N1 = 35;

const int E1 = 13;
const int M1 = 12;
const int E2 = 11;
const int M2 = 10;

const int cSensor = A6;   // Sensor inputs
const int vSensor = A4;
const int fSensor = A2; 


void setup(){
  // to run once
  pinMode(V1, OUTPUT);
  pinMode(V2, OUTPUT);
  pinMode(V3, OUTPUT);
  pinMode(V4, OUTPUT);
  pinMode(V5, OUTPUT);
  pinMode(V6, OUTPUT);
  pinMode(N1, OUTPUT);
  pinMode(I1, OUTPUT);
  pinMode(I2, OUTPUT);
  pinMode(I3, OUTPUT);
  pinMode(Ve2, OUTPUT);
  pinMode(Ve1_Ve3, OUTPUT);

  digitalWrite(I1, LOW);
  digitalWrite(I3, LOW);
  digitalWrite(N1, LOW);
  pinMode(E1, OUTPUT);
  pinMode(M1, OUTPUT);
  pinMode(E2, OUTPUT);
  pinMode(M2, OUTPUT);
  pinMode(I1, OUTPUT);
  pinMode(Ve1_Ve3, OUTPUT);

  pinMode(fSensor, INPUT);
  pinMode(cSensor, INPUT);
  pinMode(vSensor, INPUT);

// Initiate pump
  digitalWrite(M1, LOW);
  digitalWrite(M2, LOW);

// Initiate serial communication.
  Serial.begin(9600);
  delay(150);

// Close the flow layer.
  digitalWrite(N1, LOW);
  digitalWrite(I1, LOW);
  digitalWrite(I2, LOW);
  digitalWrite(I3, LOW);

// Close (activate) all valves in the control layer
  digitalWrite(V1, HIGH);     
  digitalWrite(V2, HIGH);
  digitalWrite(V3, HIGH); 
  digitalWrite(V4, HIGH);
  digitalWrite(V5, HIGH);
  digitalWrite(V6, HIGH);

// Reset Flow Pressure
  digitalWrite(Ve1_Ve3, HIGH);
  delay(1000);
  digitalWrite(Ve1_Ve3, LOW);

// Initial Pressure Set Points  
  flowTargetPressure = 1;
  valveTargetPressure = 25;
  negativeTargetPressure = 1;

  timeInitial = millis();
  Serial.println(timeInitial);
  highPressureControl();
}


void loop(){
  if(pump){
    timeFinal = millis();
    if(timeFinal - timeInitial > 5000){
      timeInitial = millis();
      cVoltage = analogRead(cSensor)*0.0049;
      valvePressure = cVoltage*6.1328+4.7401;
      if(valvePressure < valveTargetPressure - 5){
        highPressureControl();  
      }
    }
  }

  if(Serial.available()){
    int val = Serial.read();
    
    if(val == 0){
      // Function "Idle"
      // Pressurizes all valves except circular ones
      
      Serial.println("Ready");
      highPressureControl();
      pump = true;
      digitalWrite(V1, HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V3, LOW);    // circularValves
      digitalWrite(V4, HIGH);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, HIGH);
    }
    
    if(val == 7){
      // Function "Valves"
      // Pressurize all valves to fill with DI water
      
      Serial.println("Pressurize valves");
      highPressureControl();
      pump = true;
      digitalWrite(V1, HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V3, HIGH);
      digitalWrite(V4, HIGH);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, HIGH);
    }
    
    if(val == 8){
      // Function "Stop"
      // Depressurizes the system - deactivates all valves
      
      Serial.println("Stop");
      pump = false;
      digitalWrite(V1, LOW);
      digitalWrite(V2, LOW);
      digitalWrite(V3, LOW);
      digitalWrite(V4, LOW);
      digitalWrite(V5, LOW);
      digitalWrite(V6, LOW);
      digitalWrite(Ve2, HIGH);
      delay(2000);
      digitalWrite(Ve2, LOW);
    }

    if(val == 1){
      // Function "Hold Pressure"
      // Keeps high pressure stable
      holdPressure();
      }
    
    if(val == 2){
      // Function "Pull plasma"
      // Pulls plasma into the collection channel
      pullPlasma();
      val == 0;
      }
    
    if(val == 3){
      // Function "Fill Reagent"
      // Moves reagents into reaction chambers
      fillReagent();
      }
    
    if(val == 4){
      // Function "Push Plasma"
      // Moves plasma into reaction chambers
      pushPlasma();
      }
    
    if(val == 5){
      // Function "Degassing"
      // Removes air from reaction chambers
      degassing();
      val == 0;
      }
    
    if(val == 6){
      // Function "Mixing"
      // Activates active mixing for 8 min
      mixing();
      val == 0;
      }

    // FULL AUTOMATION
    if(val == 9){
      // Funtion "Automate"
      // Runs all steps in order
      Serial.println("Automate");
      // val == 0;  // Activate valves, except V2
      highPressureControl();
      pump = true;
      digitalWrite(V1, HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V3, LOW);    // circularValves
      digitalWrite(V4, HIGH);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, HIGH);
      delay(10000);
      Serial.println("Valves Ready");
      
      // val == 2;  // Pull plasma into collection channel
      highPressureControl();
      Serial.println("Extract plasma");
      digitalWrite(V1, LOW);            // Open valves to let plasma enter serpentine and chambers.
      digitalWrite(V2, HIGH);
      digitalWrite(V3, LOW);
      digitalWrite(V4, LOW);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, LOW);
      digitalWrite(N1, HIGH);
      negativePressureControl(15000);   // Change this value (in ms) if the plasma is not traveling the correct distance
      digitalWrite(N1, LOW);
      Serial.println("Stop Plasma");
      digitalWrite(V1, HIGH);
      highPressureControl();

      // val == 4;  // Push plasma into reaction chambers
      highPressureControl();
      Serial.println("Push plasma into chambers");
      digitalWrite(V1, HIGH);
      digitalWrite(V2, LOW);
      digitalWrite(V3, LOW);
      digitalWrite(V4, LOW);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, LOW);
      flowTargetPressure = 0.5;
      digitalWrite(V2, LOW);
      digitalWrite(I1, HIGH);
      lowPressureControl(1000);         // Change this value as needed
      digitalWrite(I1, LOW);            // Stop air flow, seal the device outputs
      Serial.println("Stop plasma");
      highPressureControl();
      
      // val == 3;  // Push reagents into reaction chambers
      highPressureControl();
      Serial.println("Fill reagents"); 
      digitalWrite(V1, HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V3, LOW);
      digitalWrite(V4, LOW);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, LOW);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, HIGH);
      lowPressureControl(5000);       // Change this if reagents are not traveling the correct distance
      digitalWrite(I2, LOW);          // Close reagent inputs, push plasma into chambers with air
      digitalWrite(I3, LOW);
      Serial.println("Stop reagents"); 
      highPressureControl();
      
      // val == 5;  // Degassing reaction chambers
      highPressureControl();
      Serial.println("Pressurize chambers to remove bubbles");
      digitalWrite(V1, HIGH);
      digitalWrite(V2, LOW);
      digitalWrite(V3, LOW);
      digitalWrite(V4, LOW);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, HIGH);
      flowTargetPressure = 4;         // Increase target pressure to remove excess air
      digitalWrite(V2, LOW);          // Pressurize chambers to force out bubbles
      digitalWrite(I1, HIGH);
      digitalWrite(I2, HIGH);
      digitalWrite(I3, HIGH);
      
      for (long i = 0; i < 5; i++)
      {
        highPressureControl();
        lowPressureControl(5000);
      }
      
      digitalWrite(V2, HIGH);
      digitalWrite(V3, HIGH);
      digitalWrite(V4, HIGH);
      digitalWrite(I1, LOW);          // Remove pressure
      digitalWrite(I2, LOW);
      digitalWrite(I3, LOW);
      highPressureControl();
      
      // val == 6;  // Activates active mixing
      int cycles = 1050;
      Serial.println("Active Mixing");
      digitalWrite(V1, HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V3, HIGH);
      digitalWrite(V4, HIGH);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, HIGH);
      digitalWrite(V6, HIGH);
      
      digitalWrite(E2,HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V4, HIGH);
      digitalWrite(V6, HIGH);
      
      for (long i = 0; i < cycles; i++)
      {
        digitalWrite(V3, HIGH);
        delay(100); //100
        digitalWrite(V5, HIGH);
        delay(100); //100
        digitalWrite(V3, LOW);
        delay(100); //100
        digitalWrite(V5, LOW);
        delay(100); //100
        
        if ((i % 15) == 0)
          {
            highPressureControl();  
          }
      }
      digitalWrite(E2,LOW);
      digitalWrite(V5, HIGH);
      highPressureControl();
      
      // val == 0;  // Seals chambers for imaging
      highPressureControl();
      pump = true;
      digitalWrite(V1, HIGH);
      digitalWrite(V2, HIGH);
      digitalWrite(V3, LOW);    // circularValves
      digitalWrite(V4, HIGH);
      digitalWrite(V5, HIGH);
      digitalWrite(V6, HIGH);
      delay(1000);
      Serial.println("Ready for Imaging");
    }

    
    }
  }




// ALL FUNCTIONS (1-6)
// Functions 0 & 7-9 are described above

void holdPressure() {
  // Function "Manual Valves"
  // Keeps high pressure stable

  Serial.println("Hold Pressure");
  highPressureControl();    // checks valves pressure
}


void pullPlasma(){
  // Function "Pull plasma"
  // Pulls plasma into the collection channel
  
  highPressureControl();
  Serial.println("Extract plasma");
  digitalWrite(V1, LOW);            // Open valves to let plasma enter serpentine and chambers.
  digitalWrite(V2, HIGH);
  digitalWrite(V3, LOW);
  digitalWrite(V4, LOW);
  digitalWrite(V5, HIGH);
  digitalWrite(V6, LOW);
  digitalWrite(N1, HIGH);
  negativePressureControl(15000);   // Change this value (in ms) if the plasma is not traveling the correct distance
  digitalWrite(N1, LOW);
  Serial.println("Stop Plasma");
  digitalWrite(V1, HIGH);
  highPressureControl();
}


void fillReagent(){
  // Function "Fill Reagent"
  // Depressurizes the system - deactivates all valves
  
  highPressureControl();
  Serial.println("Fill reagents"); 
  digitalWrite(V1, HIGH);
  digitalWrite(V2, HIGH);
  digitalWrite(V3, LOW);
  digitalWrite(V4, LOW);
  digitalWrite(V5, HIGH);
  digitalWrite(V6, LOW);
  digitalWrite(I2, HIGH);
  digitalWrite(I3, HIGH);
  lowPressureControl(5000);       // Change this if reagents are not traveling the correct distance
  digitalWrite(I2, LOW);          // Close reagent inputs, push plasma into chambers with air
  digitalWrite(I3, LOW);
  Serial.println("Stop reagents"); 
  highPressureControl();
}


void pushPlasma(){
  // Function "Push Plasma"
  // Moves plasma into reaction chambers
  
  highPressureControl();
  Serial.println("Push plasma into chambers");
  digitalWrite(V1, HIGH);
  digitalWrite(V2, LOW);
  digitalWrite(V3, LOW);
  digitalWrite(V4, LOW);
  digitalWrite(V5, HIGH);
  digitalWrite(V6, LOW);
  flowTargetPressure = 0.5;
  digitalWrite(V2, LOW);
  digitalWrite(I1, HIGH);
  lowPressureControl(1000);         // Change this value as needed
  digitalWrite(I1, LOW);            // Stop air flow, seal the device outputs
  Serial.println("Stop plasma");
  highPressureControl();
}


void degassing(){
  // Function "Degassing"
  // Removes air from reaction chambers
  
  highPressureControl();
  Serial.println("Pressurize chambers to remove bubbles");
  digitalWrite(V1, HIGH);
  digitalWrite(V2, LOW);
  digitalWrite(V3, LOW);
  digitalWrite(V4, LOW);
  digitalWrite(V5, HIGH);
  digitalWrite(V6, HIGH);
  flowTargetPressure = 4;         // Increase target pressure to remove excess air
  digitalWrite(V2, LOW);          // Pressurize chambers to force out bubbles
  digitalWrite(I1, HIGH);
  digitalWrite(I2, HIGH);
  digitalWrite(I3, HIGH);
  
  for (long i = 0; i < 5; i++)
  {
    highPressureControl();
    lowPressureControl(5000);
  }
  
  digitalWrite(V2, HIGH);
  digitalWrite(V3, HIGH);
  digitalWrite(V4, HIGH);
  digitalWrite(I1, LOW);          // Remove pressure
  digitalWrite(I2, LOW);
  digitalWrite(I3, LOW);
  highPressureControl();
}


void mixing(){
  // Function "Mixing"
  // Activates active mixing for 8 min
  
  int cycles = 1050;
  Serial.println("Active Mixing");
  digitalWrite(V1, HIGH);
  digitalWrite(V2, HIGH);
  digitalWrite(V3, HIGH);
  digitalWrite(V4, HIGH);
  digitalWrite(V5, HIGH);
  digitalWrite(V6, HIGH);
  digitalWrite(V6, HIGH);
  
  digitalWrite(E2,HIGH);
  digitalWrite(V2, HIGH);
  digitalWrite(V4, HIGH);
  digitalWrite(V6, HIGH);
  
  for (long i = 0; i < cycles; i++)
  {
    digitalWrite(V3, HIGH);
    delay(100); //100
    digitalWrite(V5, HIGH);
    delay(100); //100
    digitalWrite(V3, LOW);
    delay(100); //100
    digitalWrite(V5, LOW);
    delay(100); //100
    
    if ((i % 15) == 0)
    {
      highPressureControl();  
    }
  }
  digitalWrite(E2,LOW);
  digitalWrite(V5, HIGH);
  highPressureControl();
}


void highPressureControl(){
  // function for controlling valves pressure
  cVoltage = analogRead(cSensor)*0.0049;
  valvePressure = cVoltage*6.1328+4.7401;
  while (valvePressure < valveTargetPressure) 
  {
    digitalWrite(E2, HIGH);
    cVoltage = analogRead(cSensor)*0.0049;
    valvePressure = cVoltage*6.1328+4.7401;
  }
  digitalWrite(E2, LOW);
  while (valvePressure > valveTargetPressure) 
  {
    digitalWrite(Ve2, HIGH);
    cVoltage = analogRead(cSensor)*0.0049;
    valvePressure = cVoltage*6.1328+4.7401;
  }
  digitalWrite(Ve2, LOW);
  //  digitalWrite(E2,HIGH);
}


void lowPressureControl(unsigned long timeDelay){
  // function for controlling flow pressure
  timing = millis();
  while(millis() - timing < timeDelay)
  {
    fVoltage = analogRead(fSensor)*0.0049;
    flowPressure = fVoltage*1.6134-0.1573;
    if (flowPressure < 0)
    {
      flowPressure = 0;
    }  
    difference = abs(flowPressure - flowTargetPressure);
    while(flowPressure < (flowTargetPressure)) 
    {
      if (difference < tolerence)
       {
         break;
       }
      digitalWrite(E1, HIGH);
      digitalWrite(M1, LOW); 
      fVoltage = analogRead(fSensor)*0.0049;
      flowPressure = fVoltage*1.6134-0.1573;
      if (flowPressure < 0)
      {
        flowPressure = 0;
      }    
      difference = abs(flowPressure - flowTargetPressure);
    }
    digitalWrite(E1, LOW);  
    fVoltage = analogRead(fSensor)*0.0049;
    flowPressure = fVoltage*1.6134-0.1573;
    if (flowPressure < 0)
    {
      flowPressure = 0;
    }
    difference = abs(flowPressure - flowTargetPressure);
    while (flowPressure > flowTargetPressure) 
    {
      if (difference < tolerence)
      {
        break;
      }
      digitalWrite(Ve1_Ve3, HIGH);
      fVoltage = analogRead(fSensor)*0.0049;
      flowPressure = fVoltage*1.6134-0.1573;
      if (flowPressure < 0)
      {
        flowPressure = 0;
      }     
      difference = abs(flowPressure - flowTargetPressure);
    }
     digitalWrite(Ve1_Ve3, LOW);
  }
  timing = 0;
}


void negativePressureControl(unsigned long timeDelay){
  // function for controlling negative pressure
  timing = millis();
  while(millis() - timing < timeDelay)
  {
    digitalWrite(N1, HIGH);
    nVoltage = analogRead(vSensor)*0.0049;
    negativePressure = nVoltage*1.6134-0.2073;
//    Serial.println(negativePressure);
    if (negativePressure < 0)
    {
      negativePressure = 0;
    }  
    difference = abs(negativePressure - negativeTargetPressure);
    while(negativePressure < (negativeTargetPressure)) 
    {
      if (difference < tolerence)
      {
        break;
      }
      analogWrite(E1, 0.75*255);
      digitalWrite(M1, LOW); 
      nVoltage = analogRead(vSensor)*0.0049;
      negativePressure = nVoltage*1.6134-0.2073;
      if (negativePressure < 0)
      {
        negativePressure = 0;
      }    
      difference = abs(negativePressure - negativeTargetPressure);
    }
    digitalWrite(E1, LOW);  
    nVoltage = analogRead(vSensor)*0.0049;
    negativePressure = nVoltage*1.6134-0.2073;
    if (negativePressure < 0)
    {
      negativePressure = 0;
    }  
    difference = abs(negativePressure - negativeTargetPressure);
    while (negativePressure > negativeTargetPressure) 
    {
      if (difference < tolerence)
      {
        break;
      }
      digitalWrite(Ve1_Ve3, HIGH);
      nVoltage = analogRead(vSensor)*0.0049;
      negativePressure = nVoltage*1.6134-0.2073;
      if (negativePressure < 0)
      {
        negativePressure = 0;
      }       
      difference = abs(negativePressure - negativeTargetPressure);
    }
     digitalWrite(Ve1_Ve3, LOW);
     highPressureControl();
  }
  timing = 0;
}
