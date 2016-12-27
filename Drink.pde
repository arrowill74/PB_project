class Drink extends Food {
  //drink
  PImage glass, drinkMachineUp, drinkMachineDown;
  //drink add by cute peihsin
  boolean juicePour = false;
  boolean cokePour = false;
  boolean beerPour = false;
  int pourSpeed;
  int drinkHeight;
  boolean mouseReleased= false;

  Drink () {
    bg = loadImage("img/background/drinkBg.png");
    glass = loadImage("img/drink/glass.png");
    drinkMachineUp = loadImage("img/drink/drink machine_up.png");
    drinkMachineDown = loadImage("img/drink/drink machine_down.png");
  }

  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(glass, onTableX, onTableY, 96, 160);
    if (onClick()) {
      gameState = RUN;
      foodState = DRINK;
      playing = this;
    }
  }
  boolean onClick() {
    if (isHit(onTableX, onTableY, 96, 160, mouseX, mouseY, 1, 1) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    image(bg, 0, 0);
    image(drinkMachineDown, 0, 0);

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
    image(glass, 210, 350);
    image(drinkMachineUp, 0, 0);
  }

  void mousePressed() {
    if (mouseX>115 && mouseX<145 && mouseY>260 && mouseY<290) {//juice button 
      juicePour = true;
    } else if (mouseX>250 && mouseX<280 && mouseY>260 && mouseY<290) {//coke button
      cokePour = true;
    } else if (mouseX>375 && mouseX<405 && mouseY>260 && mouseY<290) {//beer button
      beerPour = true;
    }
  }

  void mouseReleased() {
    if (mouseX>115 && mouseX<145 && mouseY>260 && mouseY<290) {//juice button 
      mouseReleased = true;
      juicePour = false;
      //moodChange();
      initDrink();
    } else if (mouseX>250 && mouseX<280 && mouseY>260 && mouseY<290) {//coke button
      mouseReleased = true;
      cokePour = false;
      //moodChange();
      initDrink();
    } else if (mouseX>375 && mouseX<405 && mouseY>260 && mouseY<290) {//beer button
      mouseReleased = true;
      beerPour = false;
      //moodChange();
      initDrink();
    }
  }

  void initDrink() {
    pourSpeed = 0;
  }

  void displayDrink() {
    noStroke();
    quad(230, drinkHeight, 310, drinkHeight, 310, 540, 230, 540);//230~
  }

  void pourDrink() {
    rect(265, 345, 15, 200); //stream
    if (drinkHeight <= 360) {
      pourSpeed= 0;
    }           
    drinkHeight = 540+pourSpeed; //glass bottom:540
    pourSpeed--;
    quad(230, drinkHeight, 310, drinkHeight, 310, 540, 230, 540);//glass width:230~310
  }

  //void moodChange() {
  //  if (drinkHeight>=378 && drinkHeight<=392) {//effective range
  //    println(moodChange); //mood won't change
  //  } else {
  //    moodChange = true; //mood change
  //    println(moodChange);
  //  }
  //}
}