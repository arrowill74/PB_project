//background
PImage startBg, peopleBg, tableBg, table;
PFont text;

Person[] customers = new Person[3];
Food[] foods = new Food[7];
Food playing;

int curCustomer;
int foodIndex;

//game state
final int START = 0;
final int PEOPLE = 1;
final int TABLE = 2;
final int RUN = 3;
final int OVER = 4;
final int WIN = 5;
int gameState;

//food state
final int BURGER = 0;
final int FRENCH_FRIES = 1;
final int ICE_CREAM = 2;
final int DRINK = 3;
int foodState;

//arrow
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//mood
Blood[] blood = new Blood[10];
int curblood;
boolean bloodCtrl;

void setup () {
  size(700, 700);
  text = createFont("Arial", 24);

  //load background
  startBg = loadImage("img/background/startBg.png");
  peopleBg = loadImage("img/background/peopleBg.png");
  tableBg = loadImage("img/background/moodBg.png");
  table = loadImage("img/background/table.png");

  customers[0] = new Person("fTA");
  customers[0].setOrder(new int[]{BURGER, DRINK, -1, -1, -1, -1, -1});
  customers[1] = new Person("mTA");
  customers[1].setOrder(new int[]{BURGER, DRINK, FRENCH_FRIES, -1, -1, -1, -1});
  customers[2] = new Person("teacher");
  customers[2].setOrder(new int[]{ICE_CREAM, FRENCH_FRIES, FRENCH_FRIES, BURGER, BURGER, DRINK, DRINK});

  for (int i = 0; i < blood.length; i++) {
    if (i < 3) {
      blood[i] = new Blood("bad", i);
    } else if (i < 7) {
      blood[i] = new Blood("general", i);
    } else {
      blood[i] = new Blood("happy", i);
    }
  }

  initGame();
}

void draw() {
  if (curblood > 10) {
    curblood = 10;
  } else if (curblood < 0) {
    gameState = OVER;
  }
  switch (gameState) {
  case START:
    image(startBg, 0, 0, 700, 700);
    break;

  case TABLE:
    //background
    imageMode(CORNER);
    image(tableBg, 0, 0, 700, 400);
    image(table, 0, 310, 700, 400);
    bloodCtrl = false;
    customers[curCustomer].halfDisplay();
    for (int i = 0; i < blood.length; i++) {
      blood[i].display(curblood);
    }
    for (int i = 0; i < customers[curCustomer].foodCount; i++) {
      foods[i].displayOnTable();
    }
    if(curCustomer >= 3){
      gameState = PEOPLE;
    }

    break;

  case RUN:
    switch (foodState) {
    case BURGER:
      playing.display();
      break;

    case FRENCH_FRIES:
      playing.display();
      break; 


    case ICE_CREAM:
      playing.display();
      break;


    case DRINK:
      playing.display();

      break;
    }
    for (int i = 0; i < blood.length; i++) {
      blood[i].display(curblood);
    }
    break;



  case OVER :
    image(peopleBg, 0, 0, 700, 700);
    customers[0].sadDisplay(40, 250);
    customers[1].sadDisplay(260, 250);
    customers[2].sadDisplay(480, 250);
    break;

  case WIN :
    image(peopleBg, 0, 0, 700, 700);
    customers[0].fullDisplay(40, 250);
    customers[1].fullDisplay(260, 250);
    customers[2].fullDisplay(480, 250);
    break;
    
  }
}

void mousePressed() {
  if (gameState == RUN) {
    if (foodState == DRINK) {
      playing.mousePressed();
    }
  }
  if (gameState == TABLE && isHit(mouseX, mouseY, 0, 0, 650, 650, 50, 50) && checkOrder()) {
    curCustomer ++;
    customers[curCustomer].newFood();
    customers[curCustomer].setTable();
  }
}

void mouseReleased() {
  if (gameState == RUN) {
    if (foodState == DRINK) {
      playing.mouseReleased();
    }
    if (foodState == ICE_CREAM) {
      playing.mouseReleased();
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
    case UP:
      upPressed = true;
      break;
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
    }
  }
}

void keyReleased() {
  if ( keyCode == ' ') {
    if (gameState == START) {
      gameState = TABLE;
      customers[curCustomer].newFood();
      customers[curCustomer].setTable();
    }
    if (gameState == RUN) {
      if (foodState == BURGER) {
        playing.keyReleased();
      }
    }
  }

  if (key == CODED) {
    switch (keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  if (ax >= bx-aw && ax <= bx+bw && ay >= by-ah && ay <= by+bh) {
    return true;
  } else {
    return false;
  }
}

boolean checkOrder() {
  int count = 0;
  for ( int i = 0; i < 7; i++) {
    count += customers[curCustomer].order[i];
  }
  if (count == -7) {
    return true;
  } else {
    return false;
  }
}

void initGame() {
  gameState = START;
  curblood = 5;
  curCustomer = 0;
}