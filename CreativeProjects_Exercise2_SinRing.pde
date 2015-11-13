/*----------variables------------*/

float j = 0; //j is value fed into sine functions
float i = 0; //i is mapped to mouse x and added into j per frame
float z = 0; //used to oscilate ring thickness using sine(j)
float size = 196; //used to translate shapes downwards in the for loop to make ring rather than circle
float col; //makes the shapes glow white when they get to center using sin

/*-------boolean switches--------*/
boolean shape = true; //if true then use circles, otherwise rectanges
boolean play = true; //if false then pause the animation

void setup() {
  size(560, 560); //self explanatory
  colorMode(HSB, 360); //uses hue, saturation and brightness colour mode
  smooth(); //smooth dem lines
}

void draw() {
  //some shade of grey that works visually
  background(180); 
  
  //speed of animation is directly linked to mouse x
  i = map(mouseX, 0, width, -0.01, 0.01); 
  //size of the ring oscillates
  size = map(sin(j*4), -1, 1, 0, 200);
  //this fades in the white glow when all the shapes meet in middle
  col = map(sin(j*4), -1, -0.8, 0, 360);
  
  if (play) {
    //speed up/slowdown/reverse sine functions according to mouse position
    j += i; 
    //change thickness
    z = map(sin(j), -1, 1, -0.5, 1.5);
  }
  
  //brings all shapes down centre 
  pushMatrix(); 
  translate(width/2, height/2);
  //rotate everything backwars or forwards depending on j val
  rotate(j*4);
  
  //loop 360, allows me to make a circle/ring
  for (int deg = 0; deg < 360; deg++) {
    pushMatrix(); 
    //heres where the ring bit happens
    rotate(radians(deg));
    //making it bigger/smaller
    translate(0, size);

    //sin scale gives it the wavey form, z makes it thicker and thiner
    scale(map(sin(radians(deg*5.5)), -1, 1, 0.5, z), map(sin(radians(deg*11)), -1, 1, 0.5, z));
    
    //more empty than my wallet after this degree
    noFill();
    
    //hue changes as it goes round circle, col changes according to sin
    stroke(deg, col, 360);
    //skinny lines
    strokeWeight(0.2);
    
    //decide what shapes to use here
    if (shape) {
      ellipse(0, 0, 100, 100);
    } else {
      rect(-50, -50, 100, 100);
    }
    popMatrix();
  }
  popMatrix();
}

//boolean shizzzzle down here
void mousePressed() {
  shape = !shape;
}

void keyPressed() {
  if (key == ' ') {
    play = !play;
  }
}
