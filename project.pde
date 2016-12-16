//background
PImage startBg, peopleBg, tableBg;

Person fTA, mTA, teacher, customer;

Food[] foods = new Food[7];

//burger image
PImage btmbread, middlebread, topbread, 
        cheese, lettuce, meat,  tomato,
        conveyor, conveyorGlass;
//french fries
PImage emptyFrenchfries, fewFrenchfries, halfFrenchfries, fullFrenchfries, 
        bug, frenchfry, burnedFrenchfry;
        
//ice cream
PImage cone, blurberry, choco, mango, matcha, strawberry, vanilla;

//drink
PImage glass, drinkMachineUp, drinkMachineDown;

PImage clock;

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
boolean moodChange;
int moodScore;

void setup () {
  size(700, 700);
  foodState = 0; //change the value when you want to test different food
  
  //load image
  //background
  startBg = loadImage("img/background/startBg.png");
  peopleBg = loadImage("img/background/peopleBg.png");
  tableBg = loadImage("img/background/tableBg.png");

  //burger
  btmbread = loadImage("img/burger/btmbread.png");
  middlebread = loadImage("img/burger/middlebread.png");
  topbread = loadImage("img/burger/topbread.png");
  cheese = loadImage("img/burger/cheese.png");
  lettuce = loadImage("img/burger/lettuce.png");
  meat = loadImage("img/burger/meat.png");
  tomato = loadImage("img/burger/tomato.png");
  conveyor = loadImage("img/burger/conveyor.png");
  conveyorGlass = loadImage("img/burger/conveyor_glass.png");
  
  
  //french fries
  emptyFrenchfries = loadImage("img/french fries/empty_frenchfries.png");
  fewFrenchfries = loadImage("img/french fries/few_frenchfries.png");
  halfFrenchfries = loadImage("img/french fries/half_frenchfries.png");
  fullFrenchfries = loadImage("img/french fries/full_frenchfries.png");
  bug = loadImage("img/french fries/bug.png");
  frenchfry = loadImage("img/french fries/frenchfry.png");
  burnedFrenchfry = loadImage("img/french fries/frenchfry(burned).png");
  
  //ice cream
  cone = loadImage("img/ice cream/cone.png");
  blurberry = loadImage("img/ice cream/blurberry.png");
  choco = loadImage("img/ice cream/choco.png");
  mango = loadImage("img/ice cream/mango.png");
  matcha = loadImage("img/ice cream/matcha.png");
  strawberry = loadImage("img/ice cream/strawberry.png");
  vanilla = loadImage("img/ice cream/vanilla.png");
  
  //drink
  glass = loadImage("img/drink/glass.png");
  drinkMachineUp = loadImage("img/drink/drink machine_up.png");
  drinkMachineDown = loadImage("img/drink/drink machine_down.png");
  
  clock = loadImage("img/clock.png");
  
  initGame();
}

void draw() {
  switch (gameState){
    case START:
    
      image(startBg, 0 , 0, 700, 700);
    
    break;

    case PEOPLE :
      image(peopleBg, 0, 0, 700, 700);
      
      fTA.fullDisplay(40, 150);
      
      mTA.fullDisplay(260, 150);

      teacher.fullDisplay(480, 150);
      
    break;  
    
    case TABLE:
      image(tableBg, 0, 0, 700, 700);
      customer.halfDisplay();
      moodScore = 5;
    
    
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

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh){
  if(ax >= bx-aw && ax <= bx+bw && ay >= by-ah && ay <= by+bh){
    return true;
  }else{
    return false;
  }
}

void initGame(){
  gameState = START;
  for(int i = 0; i < 7; i++){
    foods[i] = null;
  }
  
  fTA = new Person("fTA");
  fTA.setOrder(new int[]{BURGER, DRINK});
  
  mTA = new Person("mTA");
  fTA.setOrder(new int[]{BURGER, FRENCH_FRIES, DRINK});
  

  teacher = new Person("teacher");
  teacher.setOrder(new int[]{BURGER, FRENCH_FRIES, ICE_CREAM, DRINK, BURGER, FRENCH_FRIES, DRINK});
  
  
  customer = new Person();
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
  if ( keyCode == ' '){
    if (gameState == START){
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