// Written by Stella
// Easing code reference: https://processing.org/examples/easing.html
// variables for easing
float peopleX;
float easing = 0.05;
// define the numbers of trees images used in trees function
int numImages = 4;
int randomNumber;
// create timearray for different barriers
//create xposition array for different barriers
float[] xposStone = new float[4];
float[] xposBear = new float[4];
float[] yOffsetStone = new float[4];
float[] yOffsetBear = new float[4];
float[] xposTree = new float[4];
float[] yOffsetTree = new float[4];
// import images.
PImage bear;
PImage stone;
PImage[] tree = new PImage[numImages];
PImage skiingpeople;
// set variables of y pos for each barrier
float yStone, yBear, yTree;
// set variables for barrier show up position and avoid overlapping
float xSpacing = 110;
float ySpacing = 500;
float yDistance = -1500; //it was -1000;
float yspeed = 10;  // Read the Value of the pressure sensor



void Round1(){
  yDistance = -2000;
  // code for speed of the game
  yspeed = map(sensorValues[3],30,1023,6,15);
  scene();
  fill(0);
  textFont(title);
  textSize(30);
  text("ROUND 1", 50, 100);
}

void Round2(){
  yDistance = -1000;
  // code for speed of the game
  yspeed = map(sensorValues[3],30,1023,8,15);
  scene();
  textFont(title);
  fill(0);
  textSize(30);
  text("ROUND 2", 50, 100);
}

void Round3(){
  yDistance = -1000;
  // code for speed of the game
  yspeed = map(sensorValues[3],30,1023,10
  
  
  
  ,20);
  textFont(title);
  scene();
  fill(0);
  textSize(30);
  text("Final Round!", 50, 100);
}


void scene() {
  background(234);
  textFont(title);
  fill(0);
  text("Score:"+score, width/2+100, 100);
  // code for skiing people
  sensorX = map(sensorValues[2],5,60,100,width-100);
  //easing the movement of skiingpeople
  image(skiingpeople, sensorX, 750, 250, 200);
  float targetX = sensorX;
  float dx = targetX - peopleX;
  peopleX += dx * easing;
  
  // code for snowflake
  for (int iter = 0; iter < 5; iter++) {
    Tussy.add(new Snowflake());
  }
  for (Snowflake thisFlake : Tussy) {
    thisFlake.render();
  }
  // end of code for snow flake
  
  // distribution codes for tree, bear, stone are written by Eric, revised by Rudy and Stella
  for (int i=0; i<xposStone.length; i++) {
    image(stone, xposStone[i], yStone+yOffsetStone[i], 80, 80);
  }
  yStone=yStone+yspeed;
  if (yStone > height+50) {
    distributeStones();
  }

  for (int i=0; i<xposTree.length; i++) {
    image(tree[i], xposTree[i], yTree+yOffsetTree[i], 150, 150);
  }
  yTree=yTree+yspeed;

  if (yTree > height+50) {
    distributeTrees();
  }

  for (int i=0; i<xposBear.length; i++) {
    image(bear, xposBear[i], yBear+yOffsetBear[i], 100, 100);
  }
  yBear=yBear+yspeed;
  if (yBear > height+50) {
    distributeBears();
  }
}

void distributeStones() {

  println(abs(yStone - yBear));
  println(abs(yStone - yTree));

  yStone = random(yDistance, -300);
 // while (abs(yStone - yBear) < ySpacing || abs(yStone - yTree) < ySpacing) {
 //   yStone = random(yDistance, -300);
 // }

  println("yStone: ", yStone);

  xposStone[0] = random(width);
  for (int i=0; i<yOffsetStone.length; i++) {
    yOffsetStone[i] = random(-100, 100);
  }

  boolean filled = false;

  while (filled == false) {
    xposStone[1] = random(width);
    if (dist(xposStone[0], yStone, xposStone[1], yStone) > xSpacing) {
      filled = true;
    }
  }

  filled = false;
  while (filled == false) {
    xposStone[2] = random(width);
    if (dist(xposStone[0], yStone, xposStone[2], yStone) > xSpacing &&
      dist(xposStone[1], yStone, xposStone[2], yStone) > xSpacing) {
      filled = true;
    }
  }

  filled = false;
  while (filled == false) {
    xposStone[3] = random(width);
    if (dist(xposStone[0], yStone, xposStone[3], yStone) > xSpacing &&
      dist(xposStone[1], yStone, xposStone[3], yStone) > xSpacing &&
      dist(xposStone[2], yStone, xposStone[3], yStone) > xSpacing) {
      filled = true;
    }
  }
}

void distributeTrees() {

  yTree = random(yDistance, -300);

 // while (abs(yTree - yBear) < ySpacing || abs(yTree - yStone) < ySpacing) {
     while (abs(yTree - yStone) < ySpacing) {
    yTree = random(yDistance, -300);
    //println(yTree - yStone);
  }

  xposTree[0] = random(width);
  for (int n = 0; n< numImages; n++) {
    randomNumber = int(random(3));
    tree[n] = loadImage("tree"+(randomNumber)+".png");
  }
  for (int i=0; i<yOffsetTree.length; i++) {
    yOffsetTree[i] = random(-100, 100);
  }

  boolean filled = false;

  while (filled == false) {
    xposTree[1] = random(width);
    for (int n = 0; n< numImages; n++) {
      randomNumber = int(random(3));
      tree[n] = loadImage("tree"+(randomNumber)+".png");
    }
    if (dist(xposTree[0], yTree, xposTree[1], yTree) > xSpacing) {
      filled = true;
    }
  }

  filled = false;
  while (filled == false) {
    xposTree[2] = random(width);
    for (int n = 0; n< numImages; n++) {
      randomNumber = int(random(3));
      tree[n] = loadImage("tree"+(randomNumber)+".png");
    }
    if (dist(xposTree[0], yTree, xposTree[2], yTree) > xSpacing &&
      dist(xposTree[1], yTree, xposTree[2], yTree) > xSpacing) {
      filled = true;
    }
  }

  filled = false;
  while (filled == false) {
    xposTree[3] = random(width);
    for (int n = 0; n< numImages; n++) {
      randomNumber = int(random(3));
      tree[n] = loadImage("tree"+(randomNumber)+".png");
    }
    if (dist(xposTree[0], yTree, xposTree[3], yTree) > xSpacing &&
      dist(xposTree[1], yTree, xposTree[3], yTree) > xSpacing &&
      dist(xposTree[2], yTree, xposTree[3], yTree) > xSpacing) {
      filled = true;
    }
  }
}

void distributeBears() {

  yBear = random(yDistance, -300);
 // while (abs(yTree - yBear) < ySpacing || abs(yStone - yBear) < ySpacing) {
   // yBear = random(yDistance, -300);
    yBear = random(yDistance, -300);
  //}

  xposBear[0] = random(width);
  for (int i=0; i<yOffsetBear.length; i++) {
    yOffsetBear[i] = random(-100, 100);
  }

  boolean filled = false;

  while (filled == false) {
    xposBear[1] = random(width);
    if (dist(xposBear[0], yBear, xposBear[1], yBear) > xSpacing) {
      filled = true;
    }
  }

  filled = false;
  while (filled == false) {
    xposBear[2] = random(width);
    if (dist(xposBear[0], yBear, xposBear[2], yBear) > xSpacing &&
      dist(xposBear[1], yBear, xposBear[2], yBear) > xSpacing) {
      filled = true;
    }
  }

  filled = false;
  while (filled == false) {
    xposBear[3] = random(width);
    if (dist(xposBear[0], yBear, xposBear[3], yBear) > xSpacing &&
      dist(xposBear[1], yBear, xposBear[3], yBear) > xSpacing &&
      dist(xposBear[2], yBear, xposBear[3], yBear) > xSpacing) {
      filled = true;
    }
  }
}
