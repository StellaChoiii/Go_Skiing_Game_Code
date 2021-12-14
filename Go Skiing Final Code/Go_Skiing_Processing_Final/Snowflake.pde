// Snowflake are originally from Openprocessing, Snowflake by TOMATO: https://openprocessing.org/sketch/1017635
 //adjusted code for snowflake (Stella and April)
class Snowflake {
 //Attributes
 float xPos, yPos, xSpeed, ySpeed, size;
 //Constructer
 Snowflake() {
  xPos = random(width);
  yPos = 0;
  xSpeed = random(-10, 10);
  ySpeed = random(-5, 5);
  size = random(1, 5);
 }

 //Actions
 void render() {
  noStroke();
  fill(255);
  ellipse(xPos, yPos, size, size);
  xPos += xSpeed;
  yPos += ySpeed;
  xPos %= width;
 }
}
// end of code for snowflake
