class FrenchFries extends Food {
  //french fries
  PImage emptyFrenchfries, fewFrenchfries, halfFrenchfries, fullFrenchfries, bug, frenchfry, burnedFrenchfry;
  //clock
  PImage clock;
  PFont second;
  int timeCount;

  // french fries 
  final int frenchfries_W = 130, frenchfries_H = 160;
  float frenchfries_X = width/2 - frenchfries_W/2, frenchfries_Y = 450; //薯條包
  // bug 
  final int bug_W = 40, bug_H = 50, bug_MIN_X = bug_W/2, bug_MAX_X = 700 - bug_W;  //蟑螂
  float bug_X, bug_Y, bugSpeed;
  // frenchfry1 & frenchfry2 
  final int frenchfry_W = 40, frenchfry_H = 100, frenchfry_MIN_X = frenchfry_W/2, frenchfry_MAX_X = 700 - frenchfry_W;
  //正常薯條
  float frenchfry1_X, frenchfry1_Y, frenchfry1Speed;
  float frenchfry2_X, frenchfry2_Y, frenchfry2Speed;
  // burnedFrenchfry 
  final int burnedFrenchfry_W = 40, burnedFrenchfry_H = 100, burnedFrenchfry_MIN_X = burnedFrenchfry_W/2, burnedFrenchfry_MAX_X = 700 - burnedFrenchfry_W; 
  float burnedFrenchfry_X, burnedFrenchfry_Y, burnedFrenchfrySpeed;
  // frenchfries count
  int numFrenchfries;

  // clock
  int clock_X, clock_Y, clock_W = 150, clock_H = 150;

  FrenchFries () {
    bg = loadImage("img/background/frenchFriesBg.png");

    //french fries
    emptyFrenchfries = loadImage("img/french fries/empty_frenchfries.png");
    fewFrenchfries = loadImage("img/french fries/few_frenchfries.png");
    halfFrenchfries = loadImage("img/french fries/half_frenchfries.png");
    fullFrenchfries = loadImage("img/french fries/full_frenchfries.png");
    bug = loadImage("img/french fries/bug.png");
    frenchfry = loadImage("img/french fries/frenchfry.png");
    burnedFrenchfry = loadImage("img/french fries/frenchfry(burned).png");

    /*--------------french fries--------------*/
    //bug
    bug_X = random( bug_MIN_X, bug_MAX_X);
    bugSpeed = random(2, 7); 
    //frenchfry1&frenchfry2
    frenchfry1_X = random( frenchfry_MIN_X, frenchfry_MAX_X);
    frenchfry2_X = random( frenchfry_MIN_X, frenchfry_MAX_X);
    frenchfry1Speed = random(2, 9);
    frenchfry2Speed = random(2, 9);  
    //burnedFrenchfry
    burnedFrenchfry_X = random( burnedFrenchfry_MIN_X, burnedFrenchfry_MAX_X);
    burnedFrenchfrySpeed = random(2, 7);
    /*--------------french fries--------------*/

    //clock
    clock_X = 530;
    clock_Y = 30;
    second = createFont("Arial", 24);
    timeCount = 1860; //30 second
  }
  void display() {
    image(bg, 0, 0);
  }
  
  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(fullFrenchfries, onTableX, onTableY, 130, 160);
    if (onClick()) {
      gameState = RUN;
      foodState = FRENCH_FRIES;
      playing = this;
    }
  }

  boolean onClick() {
    if (isHit(onTableX, onTableY, 130, 160, mouseX, mouseY, 1, 1) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}