// IMA NYU Shanghai
// Interaction Lab
// For receiving multiple values from Arduino to Processing

/*
 * Based on the readStringUntil() example by Tom Igoe
 * https://processing.org/reference/libraries/serial/Serial_readStringUntil_.html
 */
//* Resources used in the project are all from free open source, details are as below
 //* Images of bear, tree, stone, fonts are from Openprocessing, Skiing Game by Fernando:  https://openprocessing.org/sketch/693922 
 //* BGM source: Free Music Archive, Pantomime Cow by Greg Atkinson: https://freemusicarchive.org/music/Greg_Atkinson/Christmas_Losers/Pantomime_Cow
 //* Winning sound effect source: Mixkit, mixkit-funny-fail-low-tone-2876.wav
 //* Losing sound effect source: Mixkit, https://mixkit.co/free-sound-effects/game-over/
 //* tutoring page is created by April
 //* The fonts used (BLACKCHA, Montserrat-Bold, Montserrat-Regular) are from free sources Free Text Fonts: https://www.1001fonts.com/text-fonts.html
//
// the code written below is a collaboration of April and Stella, the strategy of calling page with numbers is from Rudy.
import processing.sound.*;
SoundFile BGM;
SoundFile levelcompleted;
SoundFile gameover;

import processing.serial.*;

int NUM_OF_VALUES_FROM_ARDUINO = 4;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
// green button, red button, ultrasonic, pressure sensor.
int sensorValues[];      /** this array stores values from Arduino **/

String myString = null;
Serial myPort;
//// varibales set up for skiing game
// snowflake reference: https://openprocessing.org/sketch/1017635.
ArrayList < Snowflake > Tussy = new ArrayList();

// initial xposition value for skiing people
float sensorX = width/2;
// condition for bumping into barriers
int radius = 70;
// import images.
PImage BeginBG;
PImage RedSantahat;
PImage GreenSantahat;
PImage endBG;
PImage board;
PImage tutoring;
// import fonts
PFont title;
PFont body;
PFont buttonText;
// boolean to control whether each barrier show or not
boolean start = false;
boolean end = false;
//// end of varibales set up for skiing game
//variable to control each page
int screen = 0;
float gameTime;
int score = 100;
boolean canPlay=true;

void setup() {
  size(1900, 1000);
  setupSerial();
  //// codes set up for skiing game
  //set up sounds
  BGM = new SoundFile(this, "Greg Atkinson - Pantomime Cow.mp3");
  levelcompleted = new SoundFile(this, "level completed.wav");
  gameover = new SoundFile(this, "gameover.wav");
  // set up images
  distributeStones();
  distributeTrees();
  distributeBears();
  bear = loadImage("polarbear.png");
  stone = loadImage("stone.png");
  skiingpeople = loadImage("skiingpeople.png");
  RedSantahat = loadImage("RedSantahat.png");
  GreenSantahat = loadImage("GreenSantahat.png");
  BeginBG = loadImage("SnowBegin.jpeg");
  endBG = loadImage("endBackground.png");
  board = loadImage("board.png");
  title = createFont("SnowtopCaps.otf", 80);
  body = createFont("BLKCHCRY.TTF", 20);
  tutoring = loadImage("tutoring.png");
  buttonText = createFont("Montserrat-Regular.ttf", 13);
  //// end of codes set up for skiing game
  BGM.play();
}

void draw() {
  getSerialData();
  printArray(sensorValues);
  // use the values like this!
  // sensorValues[0]
  // add your code
  // enter the name input page
  //name();
  // record time to set time limit for each round
  Begin();
  gameTime = millis()/1000;
  // transition to tutoring page
  if (screen == 3){
    background(255);
    image(tutoring,50,20,width,height-100);
    textSize(30);
    fill(8,255,96);
    text("Press Green Button to Start", 600,height-100);
    // start the game if red button is pressed
    if (sensorValues[0] == 1){
      screen = 2;
    }
  }
  // Round 1
  if (screen == 2 && gameTime<=60){
      Round1();
      if (gameTime == 60){
        // jump to pause page
        screen = 4;
      }
  } 
  if (screen == 4){
    background(255);
    textFont(title);
    textSize(50);
    text("You've Passed Round 1, Keep Going!", 10, height/2);
    textSize(30);
    text("Press the green button to continue!", 10, height/2+150);
    if (sensorValues[0] == 1){
      screen = 2;
    }
  }
  // Round 2
  if (screen == 2 && gameTime > 60 && gameTime <= 100) {
      Round2();
      if (gameTime == 100){
        // jump to pause page
        screen = 5;
      }
  }
  if (screen == 5){
    background(255);
    textFont(title);
    textSize(50);
    text("Almost there! Final Round is coming!", 10, height/2);
    textSize(30);
    text("Press the green button to continue!", 10, height/2+150);
    if (sensorValues[0] == 1){
      screen = 2;
    }
  }
  // Last Round
  if (screen == 2 && gameTime > 100){
      Round3();
      if (gameTime == 130){
        // jump to win page
        screen = 6;
      }
    } 
  if (screen == 6){
    background(255);
    End();
    fill(255);
    textFont(title);
    textSize(60);
    text("Congratuations, YOU WIN!!", 70, 180);
    BGM.stop();
    if(canPlay==true){
      levelcompleted.play();
      canPlay=false;
    }
  }
    
  // die conditions
  for (int o = 0; o < xposBear.length; o++) {
    if (dist(xposBear[o], yBear, sensorX, 550) < radius) {
      score=score-100;
      xposBear[o]=-1000;
    }
  }
  for (int t = 0; t < xposStone.length; t++) {
    if (dist(xposStone[t], yStone, sensorX, 550) < radius) {
      score=score-30;
      xposStone[t]=-1000;
    }
  }
  for (int n = 0; n < xposTree.length; n++) {
    if (dist(xposTree[n], yTree, sensorX, 550) < radius) {
      score=score-10;
      xposTree[n]=-1000;
    }
  }
  if (score<=0){
    End();
    fill(255);
    textFont(title);
    textSize(60);
    text("GAME OVER...", 70, 180);
    BGM.stop();
    if(canPlay==true){
      gameover.play();
      canPlay=false;
    }
  }
 }

void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[ 19 ], 9600);
  // WARNING!
  // You will definitely get an error here.
  // Change the PORT_INDEX to 0 and try running it again.
  // And then, check the list of the ports,
  // find the port "/dev/cu.usbmodem----" or "/dev/tty.usbmodem----"
  // and replace PORT_INDEX above with the index number of the port.

  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[NUM_OF_VALUES_FROM_ARDUINO];
}

void getSerialData() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES_FROM_ARDUINO) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
