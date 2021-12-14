// Written by April
void Begin(){
  image(BeginBG,0,0,width,height); 
  fill(245);
  rect(440,750,360,70);
  image(RedSantahat,410,715,60,60); 
  fill(245);
  rect(1080,750,360,70);
  image(GreenSantahat,1060,710,60,60); 
  textSize(128);
  fill(0);
  textFont(title);
  text("SKiing Game!!!",750,600);
  textFont(title);
  textSize(48);
  text("How to play?",460, 800); 
  textFont(title);
  textSize(48);
  text("Start Game!", 1110,800);
  // game starts when the green button is pressed
  if ( sensorValues[0] == 1){
    screen = 2;
  }
  // jump to tutoring page if the red button is pressed
  if (sensorValues[1] == 1){
    screen = 3;
  }
}
