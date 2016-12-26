//background
PImage startBg, peopleBg, tableBg, table;

Person fTA, mTA, teacher, customer;

Food[] foods = new Food[7];

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
int moodScore;

void setup () {
  size(700, 700);
  foodState = 0; //change the value when you want to test different food

  //load background
  startBg = loadImage("img/background/startBg.png");
  peopleBg = loadImage("img/background/peopleBg.png");
  tableBg = loadImage("img/background/moodBg.png");
  table = loadImage("img/background/table.png");

  initGame();
}

void draw() {
  switch (gameState) {
  case START:
    image(startBg, 0, 0, 700, 700);

    break;

  case PEOPLE :
    image(peopleBg, 0, 0, 700, 700);

    fTA.fullDisplay(40, 150);

    mTA.fullDisplay(260, 150);

    teacher.fullDisplay(480, 150);

    break;  

  case TABLE:
    //background
    imageMode(CORNER);
    image(tableBg, 0, 0, 700, 400);
    image(table, 0, 267, 700, 433);

    customer.halfDisplay();
    moodScore = 5;

    println(customer.foodCount);
    for (int i = 0; i < customer.foodCount; ++i) {
      if (customer.tableX[i] != 0) {
        foods[i].onTableX = customer.tableX[i];
        foods[i].onTableY = customer.tableY[i];
      }
    }

    break;

  case RUN:
    switch (foodState) { 
    case BURGER:

      break;


    case FRENCH_FRIES:

      break; 


    case ICE_CREAM:

      break;


    case DRINK:

      break;
    }
    break;

  case OVER :

    break;

  case WIN :

    break;
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
      gameState = PEOPLE;
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

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh) {
  if (ax >= bx-aw && ax <= bx+bw && ay >= by-ah && ay <= by+bh) {
    return true;
  } else {
    return false;
  }
}

void initGame() {
  gameState = START;
  for (int i = 0; i < 7; i++) {
    foods[i] = new Food();
  }

  fTA = new Person("fTA");
  fTA.setOrder(new int[]{BURGER, DRINK, -1, -1, -1, -1, -1});

  mTA = new Person("mTA");
  fTA.setOrder(new int[]{BURGER, FRENCH_FRIES, DRINK, -1, -1, -1, -1});

  teacher = new Person("teacher");
  teacher.setOrder(new int[]{BURGER, FRENCH_FRIES, ICE_CREAM, DRINK, BURGER, FRENCH_FRIES, DRINK});

  customer = new Person();
}

void moodChange(int num) {
  moodScore += num;
}