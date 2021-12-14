// Written by Stella
void End(){
  image(endBG,0,0,width,height);
  image(board,280,200,500,600);
  textFont(body);
  //text(saved +"'s",150,300);
  text("Your Final Score:",450,440);
  textSize(50);
  text(score,500,500); 
  noStroke();
  textSize(30);
  fill(255,0,0);
}
