//burger image
PImage btmbread, middlebread, topbread, cheese, lettuce, meat,  tomato;
//french fries
PImage emptyFrenchfries, fewFrenchfries, halfFrenchfries, fullFrenchfries, bug, frenchfry, burnedFrenchfry;
//ice cream
PImage cone, blurberry, choco, mango, matcha, strawberry, vanilla;
//drink
PImage glass;

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

boolean moodChange;


/* Add Variable Rule
when you want to add any variable, please 
1. write your name 
2. use the comment behind your variable

for example:
//add by Yuzen (put your name)
int[] burgerQueue = new burgerSeries;  //the order of the material in burger
boolean burgerFallen;  //if the material is fallen on the the interal of burger or not

*/

void setup () {
  size(700, 700);
  foodState = 0; //change the value when you want to test different food
  
  //load image
  //burger
  btmbread = loadImage("img/burger/btmbread.png");
  middlebread = loadImage("img/burger/middlebread.png");
  topbread = loadImage("img/burger/topbread.png");
  cheese = loadImage("img/burger/cheese.png");
  lettuce = loadImage("img/burger/lettuce.png");
  meat = loadImage("img/burger/meat.png");
  tomato = loadImage("img/burger/tomato.png");
  
  //french fries
  emptyFrenchfries = loadImage("img/french fries/empty_frenchfries.png");
  fewFrenchfries = loadImage("img/french fries/few_frenchfries.png");
  halfFrenchfries = loadImage("img/french fries/half_frenchfries.png");
  fullFrenchfries = loadImage("img/french fries/full_frenchfries.png");
  bug = loadImage("img/french fries/bug.png");
  frenchfry = loadImage("img/french fries/frenchfry.png");
  burnedFrenchfry = loadImage("img/french fries/frenchfry(burned).png");
  
  //ice cream cone, blurberry, choco, mango, matcha, strawberry, vanilla;
  cone = loadImage("img/ice cream/cone.png");
  blurberry = loadImage("img/ice cream/blurberry.png");
  choco = loadImage("img/ice cream/choco.png");
  mango = loadImage("img/ice cream/mango.png");
  matcha = loadImage("img/ice cream/matcha.png");
  strawberry = loadImage("img/ice cream/strawberry.png");
  vanilla = loadImage("img/ice cream/vanilla.png");
  
  glass = loadImage("img/glass.png");
  
}

void draw() {
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
        
}

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh){
  if(ax >= bx-aw && ax <= bx+bw && ay >= by-ah && ay <= by+bh){
    return true;
  }else{
    return false;
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
