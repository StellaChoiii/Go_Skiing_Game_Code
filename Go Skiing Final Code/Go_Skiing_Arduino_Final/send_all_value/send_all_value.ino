// IMA NYU Shanghai
// Interaction Lab
// For sending multiple values from Arduino to Processing
//For distance sensor
#include <NewPing.h>
#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     12  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 200 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.


//For pressure sensor
// Define FSR pin:
#define fsrpin1 A0
#define fsrpin2 A2
int Psensor1; //Variable to store FSR1 value
int Psensor2; //Variable to store FSR2 value
int yspeed; // Variable to store the highest FSR value


void setup() {
  Serial.begin(9600);
}

// April
void loop() {
  // to send values to Processing assign the values you want to send
  //this is an example
  int sensorX = digitalRead(12);
  int button1 = digitalRead(8);
  int button2 = digitalRead(9);
  Psensor1 = analogRead(fsrpin1);
  Psensor2 = analogRead(fsrpin2);

  Serial.print(button1);
  Serial.print(",");  // put comma between sensor values
  Serial.print(button2);
  Serial.print(",");  // put comma between sensor values
  //send the distance sensor value:
  Serial.print(sonar.ping_cm()); // Send ping, get distance in cm and print result (0 = outside set distance range)
  Serial.print(",");  // put comma between sensor values
  // Print the fsrreading:
  Serial.print(yspeed);
  Serial.println(); // add linefeed after sending the last sensor value


// Stella, here to use the highest value of pressure sensors as the user speed
if (Psensor1 > Psensor2){
    yspeed = Psensor1;
   } else {
    yspeed = Psensor2;
   }
  if (yspeed < 50) {
      Serial.println(" - still");
    } else if (yspeed < 700) {
     Serial.println(" - normal speed");
    } else {
    Serial.println(" - speed up");
  }
  // too fast communication might cause some latency in Processing
  // this delay resolves the issue.
  delay(500);
}
