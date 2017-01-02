class Drink extends Food {
  PImage glass, drinkMachineUp, drinkMachineDown;

  boolean juicePour = false;
  boolean cokePour = false;
  boolean beerPour = false;

  int pourSpeed;
  int drinkHeight;

  boolean mouseReleased= false;

  Drink () {
    gray = loadImage("img/grey_food/grey_glass.png");

    bg = loadImage("img/background/drinkBg.png");
    glass = loadImage("img/drink/glass.png");

    drinkMachineUp = loadImage("img/drink/drink machine_up.png");
    drinkMachineDown = loadImage("img/drink/drink machine_down.png");
  }

  //on table function
  void showGray(float x, float y) {
    imageMode(CORNER);
    image(gray, onTableX, onTableY, 96, 160);
    if (onClick()) {
      gameState = RUN;
      foodState = DRINK;
      playing = this;
    }
  }
  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(finished, x, y, 160, 130);
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
    image(drinkMachineDown, (width-drinkMachineDown.width)/2, 150);


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
    line(width/5+5, width*3/4, width/5+5+20, width*3/4);
    line(width/5+5, width*3/4+10, width/5+5+20, width*3/4+10);
    image(glass, drinkMachineDown.width/2-20, 500);
    image(drinkMachineUp, (width-drinkMachineUp.width)/2, 0+150);
  }

  void judge() {
  }

  void mousePressed() {
    if (mouseX> drinkMachineUp.width/3-15 && mouseX< drinkMachineUp.width/3+15 && mouseY>drinkMachineUp.height*0.7 && mouseY<drinkMachineUp.height*0.76) {//juice button 
      juicePour = true;
    } else if (mouseX> drinkMachineUp.width/2+15 && mouseX< drinkMachineUp.width/2+45 && mouseY>drinkMachineUp.height*0.7 && mouseY<drinkMachineUp.height*0.76) {//coke button
      cokePour = true;
    } else if (mouseX> drinkMachineUp.width*3/4 && mouseX<drinkMachineUp.width*3/4+30 && mouseY>drinkMachineUp.height*0.7 && mouseY<drinkMachineUp.height*0.76) {//beer button
      beerPour = true;
    }
  }

  void mouseReleased() {
    if (mouseX>drinkMachineUp.width/3-15 && mouseX<drinkMachineUp.width/3+15 && mouseY>drinkMachineUp.height*0.7 && mouseY<drinkMachineUp.height*0.76) {//juice button 
      mouseReleased = true;
      juicePour = false;
      moodChange();
      initDrink();
    } else if (mouseX>drinkMachineUp.width/2+15 && mouseX<drinkMachineUp.width/2+45 && mouseY>drinkMachineUp.height*0.7 && mouseY<drinkMachineUp.height*0.76) {//coke button
      mouseReleased = true;
      cokePour = false;
      moodChange();
      initDrink();
    } else if (mouseX> drinkMachineUp.width*3/4 && mouseX< drinkMachineUp.width*3/4+30 && mouseY>drinkMachineUp.height*0.7 && mouseY<drinkMachineUp.height*0.76) {//beer button
      mouseReleased = true;
      beerPour = false;
      moodChange();
      initDrink();
    }
  }

  void initDrink() {
    pourSpeed = 0;
  }

  void displayDrink() {
    noStroke();
    quad(drinkMachineDown.width/2, drinkHeight, drinkMachineDown.width/2+glass.width-40, drinkHeight, drinkMachineDown.width/2+glass.width-40, height-10, drinkMachineDown.width/2, height-10);//230~
  }

  void pourDrink() {
    rect(drinkMachineUp.width/2+35, height*2/3+25, 15, 200); //stream
    if (drinkHeight <= width-glass.height+10) {
      pourSpeed= 0;
    }           
    drinkHeight = height-10+pourSpeed; //glass bottom:geight-10
    pourSpeed--;
    quad(drinkMachineDown.width/2, drinkHeight, drinkMachineDown.width/2+glass.width-40, drinkHeight, drinkMachineDown.width/2+glass.width-40, height-10, drinkMachineDown.width/2, height-10);//glass width:drinkMachineDown.width/2~drinkMachineDown.width/2+glass.width-40
  }

  void moodChange() {
    if (drinkHeight>=width*3/4-2 && drinkHeight<=width*3/4+10+2) {//effective range
      curblood++;
      text("Nice Job!", width/2, height/2);
    } else {
      curblood--;
      text("Sucks!", width/2, height/2);
    }
  }
}