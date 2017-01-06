class Drink extends Food {
  PImage glass, drinkMachineUp, drinkMachineDown;

  boolean juicePour = false;
  boolean cokePour = false;
  boolean beerPour = false;

  int pourSpeed;
  int drinkHeight;
  int type;
  int pourType;

  boolean mouseReleased= false;

  Drink (int type) {
    state = INTRO;
    this.type = type;
    gray = loadImage("img/grey_food/grey_glass.png");
    finished = loadImage("img/grey_food/grey_glass.png");
    intro = loadImage("img/intro/drinkIntro.png");
    startBtn = loadImage("img/button/start.png");
    finBtn = loadImage("img/button/finish.png");
    againbtn = loadImage("img/button/again.png");
    bg = loadImage("img/background/drinkBg.png");
    glass = loadImage("img/drink/glass.png");

    drinkMachineUp = loadImage("img/drink/drink machine_up.png");
    drinkMachineDown = loadImage("img/drink/drink machine_down.png");
  }

  //on table function
  void showGray(float x, float y) {
    imageMode(CORNER);
    image(gray, x, y, 96, 160);
    if (onClick()) {
      gameState = RUN;
      foodState = DRINK;
      playing = this;
      foodIndex = index;
    }
  }
  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(finished, x, y, 96, 160);
  }

  boolean onClick() {
    if (isHit(onTableX, onTableY, 96, 160, mouseX, mouseY, 1, 1) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  //game run function
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
      image(drinkMachineDown, (width-drinkMachineDown.width)/2, 125);
      if (mouseReleased) {
        displayDrink();
      }

      //juice
      if (juicePour!=false) {
        noStroke();
        fill(253, 184, 27);//juice color
        pourDrink();
      }


      //coke
      if (cokePour!=false) {
        noStroke();
        fill(119, 27, 13);//coke color
        pourDrink();
      }

      //beer
      if (beerPour!=false) {
        noStroke();
        fill(255, 243, 120);//beer color
        pourDrink();
      }

      strokeWeight(2);
      stroke(255, 0, 0);    
      line(width/5+5, height*3/4-25, width/5+5+20, height*3/4-25);
      line(width/5+5, height*3/4-15, width/5+5+20, height*3/4-15);
      image(glass, drinkMachineDown.width/2-20, 475);
      image(drinkMachineUp, (width-drinkMachineUp.width)/2, 125);
      break;

    case FINISH :
      displayDrink();
      image(glass, drinkMachineDown.width/2-20, 475);
      textFont(text, 60);
      textAlign(CENTER);
      //fill(0);
      if (judge()) {
        image(finBtn, 600, 650);
        if (isHit(mouseX, mouseY, 0, 0, 600, 650, finBtn.width, finBtn.height) && mousePressed) {
          foods[foodIndex].done = true;
          customers[curCustomer].order[foodIndex] = -1;
          gameState = TABLE;
          soundCtrl = false;
        }
      } else {
        image(againbtn, 600, 650);
        if (isHit(mouseX, mouseY, 0, 0, 600, 650, againbtn.width, againbtn.height) && mousePressed) {
          soundCtrl = false;
          drinkHeight = height-35;
          state = PLAY;
        }
      }
      break;
    }
  }

  boolean judge() {
    if (type == pourType) {
      if (drinkHeight>=height*3/4-25-2 && drinkHeight<=height*3/4-15+2) {
        text("Right Drink and Right Height", width/2, height/2);
        if (!soundCtrl) {
          complete.trigger();
          soundCtrl = true;
        }
        return true;
      } else {
        text("Right Drink but Wrong Height", width/2, height/2);
        if (!soundCtrl) {
          wrong.trigger();
          soundCtrl = true;
        }
        return false;
      }
    } else {
      text("Totally Wrong", width/2, height/2);
      if (!soundCtrl) {
        wrong.trigger();
        soundCtrl = true;
      }
      return false;
    }
  }

  void mousePressed() {
    if (state == PLAY) {
      if (mouseX> drinkMachineUp.width/3-15 && mouseX< drinkMachineUp.width/3+15 && mouseY>drinkMachineUp.height*0.7-25 && mouseY<drinkMachineUp.height*0.76-25) {//juice button 
        juicePour = true;
      } else if (mouseX> drinkMachineUp.width/2+15 && mouseX< drinkMachineUp.width/2+45 && mouseY>drinkMachineUp.height*0.7-25 && mouseY<drinkMachineUp.height*0.76-25) {//coke button
        cokePour = true;
      } else if (mouseX> drinkMachineUp.width*3/4 && mouseX<drinkMachineUp.width*3/4+30 && mouseY>drinkMachineUp.height*0.7-25 && mouseY<drinkMachineUp.height*0.76-25) {//beer button
        beerPour = true;
      }
    }
  }

  void mouseReleased() {
    if (state == PLAY) {
      if (mouseX>drinkMachineUp.width/3-15 && mouseX<drinkMachineUp.width/3+15 && mouseY>drinkMachineUp.height*0.7-25 && mouseY<drinkMachineUp.height*0.76-25) {//juice button 
        mouseReleased = true;
        juicePour = false;
        pourType = 0;
        moodChange();
        initDrink();
        state = FINISH;
      } else if (mouseX>drinkMachineUp.width/2+15 && mouseX<drinkMachineUp.width/2+45 && mouseY>drinkMachineUp.height*0.7-25 && mouseY<drinkMachineUp.height*0.76-25) {//coke button
        mouseReleased = true;
        cokePour = false;
        pourType = 1;
        moodChange();
        initDrink();
        state = FINISH;
      } else if (mouseX> drinkMachineUp.width*3/4 && mouseX< drinkMachineUp.width*3/4+30 && mouseY>drinkMachineUp.height*0.7-25 && mouseY<drinkMachineUp.height*0.76-25) {//beer button
        mouseReleased = true;
        beerPour = false;
        pourType = 2;
        moodChange();
        initDrink();
        state = FINISH;
      }
    }
  }

  void initDrink() {
    pourSpeed = 0;
  }

  void displayDrink() {
    noStroke();
    quad(drinkMachineDown.width/2, drinkHeight, drinkMachineDown.width/2+glass.width-40, drinkHeight, drinkMachineDown.width/2+glass.width-40, height-35, drinkMachineDown.width/2, height-35);//230~
  }

  void pourDrink() {
    rect(drinkMachineUp.width/2+35, height*2/3, 15, 200); //stream
    if (drinkHeight <= height-glass.height-15) {
      pourSpeed= 0;
    }           
    drinkHeight = height-35+pourSpeed; //glass bottom:height-35
    pourSpeed--;
    quad(drinkMachineDown.width/2, drinkHeight, drinkMachineDown.width/2+glass.width-40, drinkHeight, drinkMachineDown.width/2+glass.width-40, height-35, drinkMachineDown.width/2, height-35);//glass width:drinkMachineDown.width/2~drinkMachineDown.width/2+glass.width-40
  }

  void moodChange() {
    if (drinkHeight>=height*3/4-35-2 && drinkHeight<=height*3/4-50+2) {//effective range
      curblood++;
    } else {
      curblood--;
    }
  }
}