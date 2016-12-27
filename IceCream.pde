class IceCream extends Food {
  //ice cream
  PImage cone, blueberry, choco, mango, matcha, strawberry, vanilla, empty, icecream, frost, scoop, scoop_b, scoop_c, scoop_m, scoop_matcha, scoop_s, scoop_v ;
  //clock
  PImage clock;
  PFont second;
  int timeCount;

  // clock
  int clock_X, clock_Y, clock_W = 150, clock_H = 150;

  /*--------------ice cream--------------*/
  // cone 
  final int cone_W = 100, cone_H = 160;
  int cone_X = 550, cone_Y = 490;
  // icecream box 
  final int icecream_W = 465, icecream_H = 300;
  int icecream_X = 40, icecream_Y = 320;
  int blueberry_X, blueberry_Y, choco_X, choco_Y, mango_X, mango_Y, matcha_X, matcha_Y, strawberry_X, strawberry_Y, vanilla_X, vanilla_Y;
  int box_W = 120, box_H = 120;
  // icecream put
  int put_W = 100, put_H = 100, put_X = 550, put1_Y, put2_Y, put3_Y;
  PImage [] putlist = {vanilla, blueberry, mango, choco, strawberry, matcha, empty}; //prepare each ice cream image
  int putIcecream1=6, putIcecream2=6, putIcecream3=6; //display three put , empty=6
  boolean put; 
  int putCount; 
  // order
  PFont orderCha;
  PImage [] orderlist = {vanilla, blueberry, mango, choco, strawberry, matcha}; //prepare each ice cream image
  int order1=6, order2=6, order3=6, order1_X = 200, order_Y = 150, order2_X, order3_X; //display three order

  int [] orderIcecream() {         //order random and duplicate
    int[] order = new int[3];
    int pickOrder;
    for (int i=0; i<3; i++) {
      pickOrder = int(random(0, 6));
      while (isExist(pickOrder, order)) {
        pickOrder = int(random(0, 6));
      }
      order[i] = pickOrder;
    }
    order1 = order[0]-1;
    order2 = order[1]-1;
    order3 = order[2]-1;
    return order;
  }
  boolean isExist(int pickOrder, int[]order) {
    for (int i=0; i<order.length; i++) {
      if (order[i] == pickOrder) {
        return true;
      }
    }
    return false;
  }
  // scoop 
  final int scoop_W = 135, scoop_H = 60;

  float scoop_X, scoop_Y;
  final int EMPTY = 0;
  final int VANILLA = 1;
  final int BLUEBERRY = 2;
  final int MANGO = 3;
  final int CHOCO = 4;
  final int STRAWBERRY = 5;
  final int MATCHA = 6;
  int scoopState;
  // frost
  float alpha_v, alpha_b, alpha_m, alpha_c, alpha_s, alpha_matcha;  
  float speed_v, speed_b, speed_m, speed_c, speed_s, speed_matcha;  //change alpha speed
  float accessibleSecond_v, accessibleSecond_b, accessibleSecond_m, accessibleSecond_c, accessibleSecond_s, accessibleSecond_matcha; //keep alpha=0 time
  //check
  int isRight(int []order, int []put) {
    for (int i=0; i<order.length; i++) {
      for (int j=0; j<put.length; j++) {
        if (order[i] != put[i]) {
          return 0;
        }
      }
    }
    return 1;
  }
  /*--------------ice cream--------------*/
  IceCream () {
    bg = loadImage("img/background/iceCreamBg.png");

    //ice cream
    cone = loadImage("img/ice cream/cone.png");
    blueberry = loadImage("img/ice cream/blueberry.png");
    choco = loadImage("img/ice cream/choco.png");
    mango = loadImage("img/ice cream/mango.png");
    matcha = loadImage("img/ice cream/matcha.png");
    strawberry = loadImage("img/ice cream/strawberry.png");
    vanilla = loadImage("img/ice cream/vanilla.png");
    icecream = loadImage("img/ice cream/icecream.png");
    frost = loadImage("img/ice cream/frost.png");
    scoop = loadImage("img/ice cream/scoop.png");
    scoop_b = loadImage("img/ice cream/scoop_b.png");
    scoop_c = loadImage("img/ice cream/scoop_c.png");
    scoop_m = loadImage("img/ice cream/scoop_m.png");
    scoop_matcha = loadImage("img/ice cream/scoop_matcha.png");
    scoop_s = loadImage("img/ice cream/scoop_s.png");
    scoop_v = loadImage("img/ice cream/scoop_v.png");
    frost = loadImage("img/ice cream/frost.png");

    //clock
    clock_X = 530;
    clock_Y = 30;
    second = createFont("Arial", 24);
    timeCount = 1860; //30 second

    /*--------------ice cream--------------*/
    //order
    orderCha = createFont("Arial", 24);
    orderlist[0] = loadImage("img/ice cream/vanilla.png");
    orderlist[1] = loadImage("img/ice cream/blueberry.png");
    orderlist[2] = loadImage("img/ice cream/mango.png");
    orderlist[3] = loadImage("img/ice cream/choco.png");
    orderlist[4] = loadImage("img/ice cream/strawberry.png");
    orderlist[5] = loadImage("img/ice cream/matcha.png");
    order2_X = order1_X + 100;
    order3_X = order2_X + 100;
    orderIcecream();
    //icecream box
    vanilla_X = icecream_X + 17;
    vanilla_Y = icecream_Y + 15;  
    blueberry_X = vanilla_X + box_W + 34;
    blueberry_Y = icecream_Y + 15;
    mango_X = blueberry_X + box_W + 34;
    mango_Y = icecream_Y + 15;  
    choco_X = icecream_X + 17;
    choco_Y = vanilla_Y + box_H + 35;
    strawberry_X = choco_X+ box_W + 34;
    strawberry_Y = blueberry_Y + box_H + 35;
    matcha_X =strawberry_X + box_W + 34;
    matcha_Y = mango_Y + box_W + 32;
    //put
    put1_Y = cone_Y + 25 - put_H;
    put2_Y = cone_Y + 25*2 - put_H*2;
    put3_Y = cone_Y + 25*3 - put_H*3;
    putlist[0] = loadImage("img/ice cream/vanilla.png");
    putlist[1] = loadImage("img/ice cream/blueberry.png");
    putlist[2] = loadImage("img/ice cream/mango.png");  
    putlist[3] = loadImage("img/ice cream/choco.png");
    putlist[4] = loadImage("img/ice cream/strawberry.png");
    putlist[5] = loadImage("img/ice cream/matcha.png");
    putlist[6] = loadImage("img/ice cream/empty.png"); 
    //frost
    speed_v = random(2, 5);
    speed_b = random(2, 5);
    speed_m = random(2, 5);
    speed_c = random(2, 5);
    speed_s = random(2, 5);
    speed_matcha = random(2, 5);
    accessibleSecond_v = random(5, 10);
    accessibleSecond_b = random(5, 10);
    accessibleSecond_m = random(5, 10); 
    accessibleSecond_c = random(5, 10);
    accessibleSecond_s = random(5, 10);
    accessibleSecond_matcha = random(5, 10);
    /*--------------ice cream--------------*/
  }
  void display() {
    image(bg, 0, 0);
  }

  void showFinished(float x, float y) {
    imageMode(CORNER);
    //image(fullFrenchfries, onTableX, onTableY, 130 , 160);
    if (onClick()) {
      gameState = RUN;
      foodState = ICE_CREAM;
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
}