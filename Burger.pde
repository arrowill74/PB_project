import java.util.*;
class Burger extends Food {
  PImage btmbread, middlebread, topbread, 
    cheese, lettuce, meat, tomato, 
    conveyor, conveyorGlass, plate;
  AudioSample fall;
  Ingredients[] igds = new Ingredients[6];
  Ingredients[] player = new Ingredients[7];
  List<Ingredients> burger = new ArrayList<Ingredients>();
  Ingredients falling;
  boolean igdFalling = false;

  int conveyorX; //conveyor's x
  int conveyorSpeed=5;

  int n = 1;
  float CenterOfGravity;

  // clock
  PImage clock;
  int clock_X, clock_Y, clock_W = 150, clock_H = 150;
  PFont second;
  int timeCount;

  //state
  int state;
  final int SAMPLE = 3;

  Burger () {
    fall = minim.loadSample( "sound/burgerFall.wav", 512);

    bg = loadImage("img/background/burgerBg.png");
    intro = loadImage("img/intro/burgerIntro.png");
    startBtn = loadImage("img/button/start.png");
    finBtn = loadImage("img/button/finish.png");
    gray = loadImage("img/grey_food/grey_burger.png");
    finished = loadImage("img/burger/finished.png");
    clock = loadImage("img/clock.png");
    plate = loadImage("img/burger/plate.png");

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

    state = INTRO;
    igds[0] = new Ingredients("middlebread");
    igds[1] = new Ingredients("topbread");
    igds[2] = new Ingredients("cheese");
    igds[3] = new Ingredients("lettuce");
    igds[4] = new Ingredients("meat");
    igds[5] = new Ingredients("tomato");
    player[0] = new Ingredients("btmbread");
    player[0].x = width/2-100;
    player[0].y = height-100;
    for (int i = 1; i < 7; i++) {
      player[i] = new Ingredients();
    } 

    for (int i=0; i < 6; i++) {
      igds[i].xSpeed = conveyorSpeed;
      igds[i].x = -250-250*i;
      igds[i].y = 100;
    }

    //clock
    clock_X = 530;
    clock_Y = 30;
    second = createFont("Arial", 24);
    timeCount = 360;
    randomBurger();
  }

  //on table function
  void showGray(float x, float y) {
    imageMode(CORNER);
    image(gray, x, y, 160, 130);
    if (onClick()) {
      gameState = RUN;
      foodState = BURGER;
      playing = this;
      foodIndex = index;
    }
  }

  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(finished, x, y, 160, 170);
  }

  boolean onClick() {
    if (isHit(onTableX, onTableY, 160, 130, mouseX, mouseY, 1, 1) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    image(bg, 0, 0);
    switch (state) {
    case INTRO :
      imageMode(CORNER);
      image(intro, 0, 0);
      image(startBtn, 600, 650);
      if (isHit(mouseX, mouseY, 0, 0, 600, 650, startBtn.width, startBtn.height) && mousePressed) {
        state = SAMPLE;
      }
      break;  
    case SAMPLE :
      //random burger image
      for (int i = 0; i < burger.size(); i++) {
        image(burger.get(i).img, 250, 400-i*20);
      }

      //clock display
      image(clock, clock_X, clock_Y, clock_W, clock_H);
      textFont(second, 60);
      textAlign(LEFT);
      fill(0) ;
      timeCount -- ;
      text(timeCount/60, 590, 140);
      if (timeCount <= 50) {
        timeCount = 0;
        state = PLAY;
      }
      break;

    case PLAY :
      //test sample, should be delete
      for (int i = 0; i < burger.size(); i++) {
        image(burger.get(i).img, 0, 580-i*20);
      }

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

      if (igdFalling) {
        falling.display();
        falling.falling();
        if (isHit(falling.x, falling.y, falling.img.width, falling.img.height, width/2-100, height-100-n*20, btmbread.width, btmbread.height)) {
          player[n] = new Ingredients(falling.name);
          player[n].x = falling.x;
          player[n].y = height-100-n*20;
          if (player[n].name == burger.get(n).name) {
            //curblood++;
            if (n < 7) {
              n++;
            }
          } else {
            curblood--;
            state = SAMPLE;
            wrong.trigger();
            timeCount = 240;
            n = 1;
          }
          falling.y = -1000;
          igdFalling = false;
        }
      }

      for (int i=0; i < n; i++) {
        image(burger.get(i).img, player[i].x, player[i].y);
      }

      //conveyor glass
      image(conveyorGlass, 0, 50);

      if (n == 7) {
        state = FINISH;
        complete.trigger();
      }
      break;

    case FINISH :
      float g = CenterOfGravity();
      textAlign(CENTER);
      if (g > 10) {
        text("ugly", 300, 200);
        bloodChange(bloodCtrl, -1);
      } else if (g > 5) {
        text("good", 300, 200);
        bloodChange(bloodCtrl, 1);
      } else {
        text("perfect", 300, 200);
        bloodChange(bloodCtrl, 2);
      }

      image(plate, 235, 500);
      for (int i=0; i < n; i++) {
        image(burger.get(i).img, player[i].x, player[i].y-150);
      }
      image(finBtn, 600, 650);
      if (isHit(mouseX, mouseY, 0, 0, 600, 650, finBtn.width, finBtn.height) && mousePressed) {
        foods[foodIndex].done = true;
        customers[curCustomer].order[foodIndex] = -1;
        gameState = TABLE;
      }

      break;
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
    burger.add(0, new Ingredients("btmbread"));
  }

  void keyReleased() {
    if ( keyCode == ' ') {
      for (int i=0; i<igds.length; i++) {
        if (igds[i].x>=150 && igds[i].x<=330) {
          fall.trigger();
          igds[i].disappear();
          falling = new Ingredients(igds[i].name);
          falling.x = igds[i].x;
          falling.y = 100;
          igdFalling = true;
        }
      }
    }
  }

  float CenterOfGravity() {
    float sum = 0;
    for (int i = 0; i < player.length; i++) {
      sum += (abs(player[i].x+100)-width/2);
    }
    CenterOfGravity = sum/7;
    return CenterOfGravity;
  }
}