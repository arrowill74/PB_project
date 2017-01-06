class IceCream extends Food {
  //ice cream
  PImage cone, blueberry, choco, mango, matcha, strawberry, vanilla, empty, icecream, frost, scoop, scoop01, scoop_b, scoop_c, scoop_m, scoop_matcha, scoop_s, scoop_v;

  AudioSample frozen;

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
  final int INVERSE = 7;
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
    frozen = minim.loadSample( "sound/frozen.aiff", 512);
    intro = loadImage("img/intro/iceIntro.png");
    startBtn = loadImage("img/button/start.png");
    finBtn = loadImage("img/button/finish.png");
    againbtn = loadImage("img/button/again.png");
    gray = loadImage("img/grey_food/grey_icecream.png");
    finished = loadImage("img/ice cream/finished.png");
    bg = loadImage("img/background/iceCreamBg.png");
    clock = loadImage("img/clock.png");
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
    scoop01 = loadImage("img/ice cream/scoop01.png");

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
    switch (state) {
    case INTRO :
      imageMode(CORNER);
      image(intro, 0, 0);
      image(startBtn, 600, 650);
      if (isHit(mouseX, mouseY, 0, 0, 600, 650, startBtn.width, startBtn.height) && mousePressed) {
        state = PLAY;
      }
      break;  


    case PLAY :
      /*----Cone----*/
      image(cone, cone_X, cone_Y, cone_W, cone_H);

      /*----Icecream Box----*/
      image(icecream, icecream_X, icecream_Y, icecream_W, icecream_H); 

      /*----Order----*/
      //text
      textFont(orderCha, 40) ;
      fill(0) ; 
      textAlign(LEFT);
      text("ORDER:", 20, 200) ;
      //order icecream
      image(orderlist[order1], order1_X, order_Y, 70, 70);   
      image(orderlist[order2], order2_X, order_Y, 70, 70);
      image(orderlist[order3], order3_X, order_Y, 70, 70);

      /*----Scoop----*/
      switch(scoopState) {
      case EMPTY:
        image(scoop, scoop_X, scoop_Y, scoop_W, scoop_H);
        break;
      case VANILLA: 
        image(scoop_v, scoop_X-12, scoop_Y-7, 147, 67);      
        if (putIcecream1==6 ) {                                        // if putIcecream1 is empty, put vanilla to putIcecream1
          putIcecream1 = 0;
        }
        if (putIcecream1!=0 && putIcecream2==6 && putIcecream3==6) {   //if putIcecream1 is other icecream, putIcecream2 and putIcecream3 are empty, put vanilla to putIcecream2
          putIcecream2 = 0;
        }
        if (putIcecream1!=0 && putIcecream2!=0 && putIcecream3==6) {   //if putIcecream1 and putIcecream2 are other icecream, putIcecream3 is empty, put vanilla to putIcecream3
          putIcecream3 = 0;
        }
        break;
      case BLUEBERRY:
        image(scoop_b, scoop_X-12, scoop_Y-7, 147, 67);
        if (putIcecream1==6 ) {
          putIcecream1 = 1;
        }
        if (putIcecream1!=1 && putIcecream2==6 && putIcecream3==6) {
          putIcecream2 = 1;
        }
        if (putIcecream1!=1 && putIcecream2!=1 && putIcecream3==6) {
          putIcecream3 = 1;
        }       
        break;    
      case MANGO:
        image(scoop_m, scoop_X-12, scoop_Y-7, 147, 67);
        if (putIcecream1==6 ) {
          putIcecream1 = 2;
        }
        if (putIcecream1!=2 && putIcecream2==6 && putIcecream3==6) {
          putIcecream2 = 2;
        }
        if (putIcecream1!=2 && putIcecream2!=2 && putIcecream3==6 ) {
          putIcecream3 = 2;
        }      
        break;    
      case CHOCO:
        image(scoop_c, scoop_X-12, scoop_Y-7, 147, 67);
        if (putIcecream1==6 ) {
          putIcecream1 = 3;
        }
        if (putIcecream1!=3 && putIcecream2==6 && putIcecream3==6) {
          putIcecream2 = 3;
        }
        if (putIcecream1!=3 && putIcecream2!=3 && putIcecream3==6 ) {
          putIcecream3 = 3;
        } 
        break;    
      case STRAWBERRY:
        image(scoop_s, scoop_X-12, scoop_Y-7, 147, 67);
        if (putIcecream1==6 ) {
          putIcecream1 = 4;
        }
        if (putIcecream1!=4 && putIcecream2==6 && putIcecream3==6) {
          putIcecream2 = 4;
        }
        if (putIcecream1!=4 && putIcecream2!=4 && putIcecream3==6 ) {
          putIcecream3 = 4;
        } 
        break;    
      case MATCHA:
        image(scoop_matcha, scoop_X-12, scoop_Y-7, 147, 67);
        if (putIcecream1==6 ) {
          putIcecream1 = 5;
        }
        if (putIcecream1!=5 && putIcecream2==6 && putIcecream3==6) {
          putIcecream2 = 5;
        }
        if (putIcecream1!=5 && putIcecream2!=5 && putIcecream3==6 ) {
          putIcecream3 = 5;
        }       
        break;
      }
      scoop_X = mouseX - scoop_W/2;
      scoop_Y = mouseY - scoop_H/2;
      // scoop movement
      if (mouseX <= scoop_W/2 ) {
        scoop_X = 0;
      }
      if (mouseX >= width-scoop_W/2 ) {
        scoop_X = width-scoop_W;
      }  
      if (mouseY <= scoop_H/2 ) {
        scoop_Y = 0;
      }
      if (mouseY >= height-scoop_H/2 ) {
        scoop_Y = height-scoop_H;
      }

      /*----Time----*/
      image(clock, clock_X, clock_Y, clock_W, clock_H);
      textFont(second, 60) ;
      textAlign(LEFT);
      fill(0) ;
      timeCount -- ;
      if (timeCount/60 >= 10) {
        text(timeCount/60, 575, 140) ;
      } else {
        text("0"+timeCount/60, 575, 140) ;
      }
      if (timeCount <= 0) {
        timeCount = 0;
      }    

      /*----UpIcecream----*/
      if (mousePressed) {
        // vanilla
        if (isHit(scoop_X, scoop_Y, 45, 45, vanilla_X, vanilla_Y, box_W, box_H)) {  
          if (255+alpha_v <= 0) {     
            scoopState = VANILLA;
          } else {
            frozen.trigger();
          }
        }
        // blurberry
        if (isHit(scoop_X, scoop_Y, 45, 45, blueberry_X, blueberry_Y, box_W, box_H)) {
          if (255+alpha_b <= 0) {
            scoopState = BLUEBERRY;
          } else {
            frozen.trigger();
          }
        }
        // mango
        if (isHit(scoop_X, scoop_Y, 45, 45, mango_X, mango_Y, box_W, box_H)) {
          if (255+alpha_m <= 0) {
            scoopState = MANGO;
          } else {
            frozen.trigger();
          }
        }    
        // choco
        if (isHit(scoop_X, scoop_Y, 45, 45, choco_X, choco_Y, box_W, box_H)) {
          if (255+alpha_c <= 0) {
            scoopState = CHOCO;
          } else {
            frozen.trigger();
          }
        }    
        // strawberry
        if (isHit(scoop_X, scoop_Y, 45, 45, strawberry_X, strawberry_Y, box_W, box_H)) {
          if (255+alpha_s <= 0) {
            scoopState = STRAWBERRY;
          } else {
            frozen.trigger();
          }
        }    
        // matcha
        if (isHit(scoop_X, scoop_Y, 45, 45, matcha_X, matcha_Y, box_W, box_H)) {
          if (255+alpha_matcha <= 0) {
            scoopState = MATCHA;
          } else {
            frozen.trigger();
          }
        }
      }
      /*----DownIcecream----*/
      if (isHit(scoop_X, scoop_Y, 45, 45, cone_X, icecream_Y, cone_W, 170) == true ) {
        scoopState = EMPTY;       
        if (!put) {
          putCount++;
        }   
        put = true;
      } else {
        put = false;
      }

      if (putCount == 1) {
        image(putlist[putIcecream1], put_X, put1_Y, put_W, put_H);
      }
      if (putCount == 2) {
        image(putlist[putIcecream1], put_X, put1_Y, put_W, put_H);
        image(putlist[putIcecream2], put_X, put2_Y, put_W, put_H);
      }   
      if (putCount == 3) {
        image(putlist[putIcecream1], put_X, put1_Y, put_W, put_H);
        image(putlist[putIcecream2], put_X, put2_Y, put_W, put_H);      
        image(putlist[putIcecream3], put_X, put3_Y, put_W, put_H);
        state = FINISH;
      }

      /*----Frost----*/
      //vanilla   
      alpha_v -= speed_v;
      tint(255, 255+alpha_v);
      if (255+alpha_v <= -accessibleSecond_v*speed_v) {
        alpha_v = 0;
      }
      image(frost, vanilla_X, vanilla_Y, box_W, box_H);
      noTint();
      //blueberry
      alpha_b -= speed_b;
      tint(255, 255+alpha_b);
      if (255+alpha_b <= -accessibleSecond_b*speed_b) {
        alpha_b = 0;
      }
      image(frost, blueberry_X, vanilla_Y, box_W, box_H);
      noTint();
      //mango
      alpha_m -= speed_m;
      tint(255, 255+alpha_m);
      if (255+alpha_m <= -accessibleSecond_m*speed_m) {
        alpha_m = 0;
      }
      image(frost, mango_X, mango_Y, box_W, box_H);
      noTint();
      //choco
      alpha_c -= speed_c;
      tint(255, 255+alpha_c);
      if (255+alpha_c <= -accessibleSecond_c*speed_c) {
        alpha_c = 0;
      }
      image(frost, choco_X, choco_Y, box_W, box_H);
      noTint();
      //strawberry
      alpha_s -= speed_s;
      tint(255, 255+alpha_s);
      if (255+alpha_s <= -accessibleSecond_s*speed_s) {
        alpha_s = 0;
      }
      image(frost, strawberry_X, strawberry_Y, box_W, box_H);
      noTint();
      //matcha
      alpha_matcha -= speed_matcha; 
      tint(255, 255+alpha_matcha);
      if (255+alpha_matcha <= -accessibleSecond_matcha*speed_matcha) {
        alpha_matcha = 0;
      }                 
      image(frost, matcha_X, matcha_Y, box_W, box_H);
      noTint();


      break;

    case FINISH :
      image(cone, 300, cone_Y, cone_W, cone_H);
      image(putlist[putIcecream1], 300, put1_Y, put_W, put_H);
      image(putlist[putIcecream2], 300, put2_Y, put_W, put_H);      
      image(putlist[putIcecream3], 300, put3_Y, put_W, put_H);
      textFont(text, 60);
      //textAlign(CENTER);
      /*----Check----*/
      int []orderCheck = {order1, order2, order3};
      int []putCheck = {putIcecream1, putIcecream2, putIcecream3};
      textAlign(CENTER);
      if (isRight(orderCheck, putCheck) != 1) {
        text("Wrong", 350, 200);
        bloodChange(bloodCtrl, -1);
        image(againbtn, 600, 650);
        if (isHit(mouseX, mouseY, 0, 0, 600, 650, againbtn.width, againbtn.height) && mousePressed) {
          initIceCream();
          state = PLAY;
        }
      } else {
        text("Right", 350, 200);
        bloodChange(bloodCtrl, 1);
        image(finBtn, 600, 650);
        if (isHit(mouseX, mouseY, 0, 0, 600, 650, finBtn.width, finBtn.height) && mousePressed) {
          foods[foodIndex].done = true;
          customers[curCustomer].order[foodIndex] = -1;
          gameState = TABLE;
        }
      }
      break;
    }
  }


  void showFinished(float x, float y) {
    imageMode(CORNER);
    image(finished, x, y, 50, 150);
  }
  void showGray(float x, float y) {
    imageMode(CORNER);
    image(gray, x, y, 50, 150);
    if (onClick()) {
      gameState = RUN;
      foodState = ICE_CREAM;
      playing = this;
      foodIndex = index;
    }
  }

  boolean onClick() {
    if (isHit(onTableX, onTableY, 50, 150, mouseX, mouseY, 1, 1) && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void initIceCream() {
    timeCount = 1860; //30 second
    orderIcecream();
    putCount = 0;
    putIcecream1=6;
    putIcecream2=6;
    putIcecream3=6;
  }
}