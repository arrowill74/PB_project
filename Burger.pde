import java.util.*;
class Burger extends Food {
  PImage btmbread, middlebread, topbread, 
    cheese, lettuce, meat, tomato, 
    conveyor, conveyorGlass;
  Ingredients[] igds = new Ingredients[6]; //上面的食材
  int conveyorX; //conveyor's x
  int conveyorSpeed=5;
  List<Ingredients> burger = new ArrayList<Ingredients>(); //random 漢堡
  Ingredients falling;
  boolean igdFalling = false;
  Ingredients[] player = new Ingredients[6]; //建造中的漢堡
  int n = -1; //第幾層漢堡
  float CenterOfGravity; //重心

  Burger () {

    bg = loadImage("img/background/burgerBg.png");
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

    igds[0] = new Ingredients("middlebread");
    igds[1] = new Ingredients("topbread");
    igds[2] = new Ingredients("cheese");
    igds[3] = new Ingredients("lettuce");
    igds[4] = new Ingredients("meat");
    igds[5] = new Ingredients("tomato");

    for (int i=0; i<6; i++) {
      igds[i].xSpeed = conveyorSpeed;
      igds[i].x =-250-250*i;
      igds[i].y=100;
    }

    randomBurger();
  }

  void display() {
    image(bg, 0, 0);
    //btm bread
    image(btmbread, width/2-100, height-100);

    //conveyor roll
    conveyorX+=conveyorSpeed; 
    if (700+conveyorX%700>700) {
      image(conveyor, -700, 100);
    }
    image(conveyor, -700+conveyorX%700, 100);
    image(conveyor, 0+conveyorX%700, 100);     

    //igds roll
    for (int i=0; i<6; i++) {
      if (igds[i]!=null) {
        igds[i].display();
        igds[i].move();
      }
    }

    //if (falling!=null) {
    if (igdFalling==true) {
      falling.display();
      falling.falling();  
      if (isHit(falling.x, falling.y, falling.img.width, falling.img.height, width/2-100, height-100-n*20, btmbread.width, btmbread.height)) {
        falling.y=height-100-n*20;
        player[n] = new Ingredients(falling.name);
        player[n].x = falling.x;
        player[n].y = falling.y;
        println(n+"/"+ player[n].x+"/"+ player[n].y);
        if (player[n].name==burger.get(n).name) {
          for (int i=0; i<n+1; i++) {
            image(burger.get(i).img, player[i].x, player[i].y );
          }
          //moodChange = false;
        } else {
          //replay
          //moodChange = true;
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
      image(burger.get(i).img, 0, 580-i*20);
    }

    //conveyor glass
    image(conveyorGlass, 0, 50);
  }

  void randomBurger() {
    burger.add(new Ingredients("cheese"));
    burger.add(new Ingredients("lettuce"));
    burger.add(new Ingredients("meat"));
    burger.add(new Ingredients("tomato"));
    Collections.shuffle(burger);
    burger.add(new Ingredients("topbread"));
    burger.add(2, new Ingredients("middlebread"));
    burger.add(0, new Ingredients("btmbread"));
  }

  void showFinished(float x, float y) {
    imageMode(CORNER);
    for (int i = 0; i < burger.size(); i++) {
      image(burger.get(i).img, x, y+16*(6-i), 160, 80);
      //image(burger.get(i).img, x, y+20*(8-i), 200, 100);
    }
    if (onClick()) {
      gameState = RUN;
      foodState = BURGER;
      playing = this;
    }
  }

  boolean onClick() {
    if (isHit(onTableX, onTableY, 160, 96, mouseX, mouseY, 1, 1) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void conveyorDisplay() {
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
        for (int i=0; i<igds.length; i++) {
          if (igds[i].x>=150 && igds[i].x<=330) {
            //if (falling == null) {
            igds[i].disappear();
            falling = new Ingredients(igds[i].name);
            falling.x = igds[i].x;
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
  float CenterOfGravity() {
    float sum = 0;
    for (int i = 0; i < player.length; i++) {
      sum += (player[i].x/2)-(width/2-100);
    }
    // CenterOfGravity = sum/6;
    return CenterOfGravity;
  }
}