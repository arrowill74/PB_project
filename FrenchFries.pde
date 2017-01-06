class FrenchFries extends Food {
  //french fries
  PImage emptyFrenchfries, fewFrenchfries, halfFrenchfries, fullFrenchfries, bug, frenchfry, burnedFrenchfry;
  //clock
  PImage clock;
  PFont second;
  int timeCount;
  AudioSample bugSound;
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
    bugSound = minim.loadSample( "sound/bug.mp3", 512);
    intro = loadImage("img/intro/FFIntro.png");
    startBtn = loadImage("img/button/start.png");
    finBtn = loadImage("img/button/finish.png");
    againbtn = loadImage("img/button/again.png");
    gray = loadImage("img/grey_food/grey_frenchfries.png");
    finished = loadImage("img/french fries/full_frenchfries.png");
    bg = loadImage("img/background/frenchFriesBg.png");
    clock = loadImage("img/clock.png");
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
    timeCount = 930;
  }
  void display() {
    image(bg, 0, 0);
    switch (state) {
    case INTRO :
      imageMode(CORNER);
      image(intro, 0, 0);
      image(startBtn, 600, 650);
      if (isHit(mouseX, mouseY, 0, 0, 600, 650, startBtn.width, startBtn.height) && mousePressed) {
        state = PLAY;
      }
      break;  


    case PLAY :
      /*----Bag----*/
      image(emptyFrenchfries, frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H);
      frenchfries_X = mouseX - frenchfries_W/2;
      // bag movement
      if (mouseX <= frenchfries_W/2 ) {
        frenchfries_X = 0;
      }
      if (mouseX >= width-frenchfries_W/2 ) {
        frenchfries_X = width-frenchfries_W;
      }
      // bag change
      if (numFrenchfries >= 5) {
        image(fewFrenchfries, frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H);
      }
      if (numFrenchfries >= 10) {
        image(halfFrenchfries, frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H);
      }
      if (numFrenchfries >= 15) {
        image(fullFrenchfries, frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H);
      }

      /*----Time----*/
      image(clock, clock_X, clock_Y, clock_W, clock_H);
      textFont(second, 60) ;
      textAlign(LEFT);
      fill(0) ;
      timeCount -- ;
      if (timeCount/60 >= 10) {
        text(timeCount/60, 575, 140) ;
      } else {
        text("0"+timeCount/60, 575, 140) ;
      }
      if (timeCount <= 0) {
        timeCount = 0;
        state = FINISH;
      }

      /*----Drop----*/
      // bug
      image(bug, bug_X, bug_Y, bug_W, bug_H);
      bug_Y += bugSpeed;
      if (bug_Y >= height) {
        bug_Y = 0;
        bug_X = random( bug_MIN_X, bug_MAX_X);
      }    
      // frenchfry1
      image(frenchfry, frenchfry1_X, frenchfry1_Y, frenchfry_W, frenchfry_H);
      frenchfry1_Y += frenchfry1Speed; 
      if (frenchfry1_Y >= height) {
        frenchfry1_Y = 0;
        frenchfry1_X = random( frenchfry_MIN_X, frenchfry_MAX_X);
      }     
      // frenchfry2 
      image(frenchfry, frenchfry2_X, frenchfry2_Y, frenchfry_W, frenchfry_H);
      frenchfry2_Y += frenchfry2Speed;
      if (frenchfry2_Y >= height) {
        frenchfry2_Y = 0;
        frenchfry2_X = random( frenchfry_MIN_X, frenchfry_MAX_X);
      }     
      // burnedFrenchfry
      image(burnedFrenchfry, burnedFrenchfry_X, burnedFrenchfry_Y, burnedFrenchfry_W, burnedFrenchfry_H);
      burnedFrenchfry_Y += burnedFrenchfrySpeed;
      if (burnedFrenchfry_Y >= height) {
        burnedFrenchfry_Y = 0;
        burnedFrenchfry_X = random( burnedFrenchfry_MIN_X, burnedFrenchfry_MAX_X);
      }

      /*----Catch----*/
      // bug
      if (isHit(frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H, bug_X, bug_Y, bug_W, bug_H) == true ) {
        bug_Y = 0;
        bug_X = random( bug_MIN_X, bug_MAX_X);
        bug_Y += bugSpeed;
        curblood -= 2;
        bugSound.trigger();
      }    
      // frenchfry1
      if (isHit(frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H, frenchfry1_X, frenchfry1_Y, frenchfry_W, frenchfry_H) == true ) {
        frenchfry1_Y = 0;
        frenchfry1_X = random( frenchfry_MIN_X, frenchfry_MAX_X);
        frenchfry1_Y += frenchfry1Speed;
        numFrenchfries ++;
        curblood ++;
      }  
      // frenchfry2 
      if (isHit(frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H, frenchfry2_X, frenchfry2_Y, frenchfry_W, frenchfry_H) == true ) {
        frenchfry2_Y = 0;
        frenchfry2_X = random( frenchfry_MIN_X, frenchfry_MAX_X);
        frenchfry2_Y += frenchfry2Speed;
        numFrenchfries ++;
        curblood ++;
      } 
      // burnedFrenchfry
      if (isHit(frenchfries_X, frenchfries_Y, frenchfries_W, frenchfries_H, burnedFrenchfry_X, burnedFrenchfry_Y, burnedFrenchfry_W, burnedFrenchfry_H) == true ) {
        burnedFrenchfry_Y = 0;
        burnedFrenchfry_X = random( burnedFrenchfry_MIN_X, burnedFrenchfry_MAX_X);
        burnedFrenchfry_Y += burnedFrenchfrySpeed;
        curblood--;
      }

      if (numFrenchfries >= 15) {
        foods[foodIndex].done = true;
        state = FINISH;
      }
      break;

    case FINISH :
      if (numFrenchfries >= 15) {
        image(fullFrenchfries, 250, 250, 200, 250);
        image(finBtn, 600, 650);
        if (!soundCtrl) {
          complete.trigger();
          soundCtrl = true;
        }
        bloodChange(bloodCtrl, 2);
        if (isHit(mouseX, mouseY, 0, 0, 600, 650, finBtn.width, finBtn.height) && mousePressed) {
          foods[foodIndex].done = true;
          customers[curCustomer].order[foodIndex] = -1;
          gameState = TABLE;
          soundCtrl = false;
        }
      } else {
        image(againbtn, 600, 650);
        if (!soundCtrl) {
          wrong.trigger();
          soundCtrl = true;
        }
        bloodChange(bloodCtrl, -1);
        if (isHit(mouseX, mouseY, 0, 0, 600, 650, againbtn.width, againbtn.height) && mousePressed) {
          state = PLAY;
          timeCount = 930;
          numFrenchfries = 0;
          soundCtrl = false;
        }
        if (numFrenchfries >= 10) {
          image(halfFrenchfries, 250, 250, 200, 250);
        } else if (numFrenchfries >= 5) {
          image(fewFrenchfries, 250, 250, 200, 250);
        } else {
          image(emptyFrenchfries, 250, 250, 200, 250);
        }
      }
      break;
    }
  }
  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(finished, x, y, 130, 160);
  }
  void showGray(float x, float y) {
    imageMode(CORNER);
    image(gray, x, y, 130, 160);
    if (onClick()) {
      gameState = RUN;
      foodState = FRENCH_FRIES;
      playing = this;
      foodIndex = index;
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