//background
PImage startBg, peopleBg, tableBg, table;

Person fTA, mTA, teacher, customer;

Food[] foods = new Food[7];
Food playing;

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

    for (int i = 0; i < customer.foodCount; i++) {
      foods[i].displayOnTable();
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
    break;

  case OVER :

    break;

  case WIN :

    break;
  }
}

void mousePressed() {
  if (gameState == RUN) {
    if (foodState == DRINK) {
      playing.mousePressed();
    }
  }
}

void mouseReleased() {
  if (gameState == RUN) {
    if (foodState == DRINK) {
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
      gameState = PEOPLE;
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

void initGame() {
  gameState = START;

  fTA = new Person("fTA");
  fTA.setOrder(new int[]{BURGER, DRINK, -1, -1, -1, -1, -1});

  mTA = new Person("mTA");
  mTA.setOrder(new int[]{BURGER, DRINK, FRENCH_FRIES, -1, -1, -1, -1});

  teacher = new Person("teacher");
  teacher.setOrder(new int[]{ICE_CREAM, FRENCH_FRIES, FRENCH_FRIES, BURGER, BURGER, DRINK, DRINK});

  customer = new Person();
}

void moodChange(int num) {
  moodScore += num;
}