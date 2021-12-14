////Reference: http://learningprocessing.com/examples/chp18/example-18-01-userinput
// Researched by April, adjusted by Rudy and Stella
//PFont f;
//// Variable to store text currently being typed
//String typing = "";
//// Variable to store saved text when return is hit
//String saved = "";

//void name() {
//  background(255);
//  f = createFont("Arial", 16);
//  int indent = 25;
//  // Set the font and fill for text
//  textFont(f);
//  fill(0);
//  // Display everything
//  text("Click in this window and type. \nHit enter to save. ", indent, 40);
//  text("Input: " + typing, indent, 190);
//  keyPressed();
//}

//void keyPressed() {
//  // If the return key is pressed, save the String and clear it
//  if (screen == 0) {
//    if (key == '\n' ) {
//      saved = typing;
//      // A String can be cleared by setting it equal to ""
//      typing = ""; 
//      // jump to begin page when name inputed 
//      screen = 1;
//    } else {
//      // Otherwise, concatenate the String
//      // Each character typed by the user is added to the end of the String variable.
//      typing = typing + key; 
//      // jump to begin page when name inputed
//      screen = 1;
//    }
//    if (screen == 1) {
//      Begin();
//    }
//  }
//}
