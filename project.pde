import java.util.*;
//burger image
PImage btmbread, middlebread, topbread, 
  cheese, lettuce, meat, tomato, 
  conveyor, conveyorGlass;
//french fries
PImage emptyFrenchfries, fewFrenchfries, halfFrenchfries, fullFrenchfries, 
  bug, frenchfry, burnedFrenchfry;

//ice cream
PImage cone, blurberry, choco, mango, matcha, strawberry, vanilla;

//drink
PImage glass, drinkMachineUp, drinkMachineDown;

PImage clock;

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

//drink add by cute peihsin
boolean juicePour = false;
boolean cokePour = false;
boolean beerPour = false;
int pourSpeed;
int drinkHeight;
boolean mouseReleased= false;

//burger add by cute peihsin
Ingredients[] ingredients = new Ingredients[6]; //上面的食材
int x; //conveyor's x
int conveyorSpeed=5;
List<Ingredients> burger = new ArrayList<Ingredients>(); //random 漢堡
Ingredients falling;
boolean igdFalling = false; 
Ingredients[] player = new Ingredients[6]; //建造中的漢堡
int n = -1; //第幾層漢堡
float CenterOfGravity; //重心

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
  conveyor = loadImage("img/burger/conveyor.png");
  conveyorGlass = loadImage("img/burger/conveyor_glass.png");

  //
  ingredients[0] = new Ingredients("middlebread");
  ingredients[1] = new Ingredients("topbread");
  ingredients[2] = new Ingredients("cheese");
  ingredients[3] = new Ingredients("lettuce");
  ingredients[4] = new Ingredients("meat");
  ingredients[5] = new Ingredients("tomato");
  for (int i=0; i<6; i++) {
    ingredients[i].x =-250-250*i;
    ingredients[i].y=100;
  }


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

  //random burger demo image
  randomBurger();
}

void draw() {
  background(52);
  switch (foodState) { 
  case BURGER:
    //btm bread
    image(btmbread, width/2-100, height-100);

    //conveyor roll
    x+=conveyorSpeed; 
    if (700+x%700>700) {
      image(conveyor, -700, 100);
    }
    image(conveyor, -700+x%700, 100);
    image(conveyor, 0+x%700, 100);     

    //ingredients roll
    for (int i=0; i<6; i++) {
      if (ingredients[i]!=null) {
        ingredients[i].display();
        ingredients[i].move();
      }
    }

    //if (falling!=null) {
      if (igdFalling==true) {
        falling.display();
        falling.falling();  
        if (isHit(falling.x, falling.y, falling.igdImage.width, falling.igdImage.height, width/2-100, height-100-n*20, btmbread.width, btmbread.height)) {
          falling.y=height-100-n*20;
          player[n] = new Ingredients(falling.name);
          player[n].x = falling.x;
          player[n].y = falling.y;
          println(n+"/"+ player[n].x+"/"+ player[n].y);
          if (player[n].name==burger.get(n).name) {
            for (int i=0; i<n+1; i++) {
              image(burger.get(i).igdImage, player[i].x, player[i].y );
            }
            moodChange = false;
          } else {
            //replay
            moodChange = true;
          }
          //println(n+"/"+burger.get(n).x+"/"+burger.get(n).y);
          //igdFalling = false;
          //falling = null;
        }
      }
    //}

    //random burger image
    image(btmbread, 0, height-100);
    for (int i = 0; i < burger.size(); i++) {
      image(burger.get(i).igdImage, 0, 580-i*20);
    }

    //conveyor glass
    image(conveyorGlass, 0, 50);

    break;

  case FRENCH_FRIES:

    break; 


  case ICE_CREAM:

    break;


  case DRINK:
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
    break;
  }
}

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh) {
  if (ax >= bx-aw && ax <= bx+bw && ay >= by-ah && ay <= by+bh) {
    return true;
  } else {
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
  if ( keyCode == ' ') {
    if (foodState == 0) {
      for (int i=0; i<ingredients.length; i++) {
        if (ingredients[i].x>=150 && ingredients[i].x<=330) {
          //if (falling == null) {
            ingredients[i].disappear();
            falling = new Ingredients(ingredients[i].name);
            falling.x = ingredients[i].x;
            falling.y = 100;
            igdFalling = true;
            n++;
          //}
          if (n>5) {
            n=0;
          }
        }
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
    moodChange();
    initDrink();
  } else if (mouseX>250 && mouseX<280 && mouseY>260 && mouseY<290) {//coke button
    mouseReleased = true;
    cokePour = false;
    moodChange();
    initDrink();
  } else if (mouseX>375 && mouseX<405 && mouseY>260 && mouseY<290) {//beer button
    mouseReleased = true;
    beerPour = false;
    moodChange();
    initDrink();
  }
}

void initDrink() {
  pourSpeed = 0;
  moodChange = false;
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

void moodChange() {
  if (drinkHeight>=378 && drinkHeight<=392) {//effective range
    println(moodChange); //mood won't change
  } else {
    moodChange = true; //mood change
    println(moodChange);
  }
}

void randomBurger() {
  burger.add(new Ingredients("cheese"));
  burger.add(new Ingredients("lettuce"));
  burger.add(new Ingredients("meat"));
  burger.add(new Ingredients("tomato"));
  Collections.shuffle(burger);
  burger.add(new Ingredients("topbread"));
  burger.add(2, new Ingredients("middlebread"));
  for (int i = 0; i < burger.size(); i++) {
    image(burger.get(i).igdImage, 0, 580-i*20);
    //println(burger.get(i).name);
  }
}

float CenterOfGravity() {
  float sum =0;
  for (int i = 0; i < player.length; i++) {
    sum+=(player[i].x/2)-(width/2-100);
  }
  // CenterOfGravity = sum/6;
  return CenterOfGravity;
}