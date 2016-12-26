class Person {

  PImage full;
  PImage halo;
  PImage half;

  int[] order = new int[7];
  float[] tableX = new float[7];
  float[] tableY = new float[7];
  int foodCount = 0;

  Person() {
  }

  Person(String who) {
    full = loadImage("img/people/" + who + ".png");
    halo = loadImage("img/people/" + who + "Halo.png");
    half = loadImage("img/people/" + who + "Half.png");

    for (int i = 0; i < 7; i++) {
      order[i] = -1;
      tableX[i] = -1;
      tableY[i] = -1;
    }
  }

  void fullDisplay(int x, int y) {
    imageMode(CORNER);
    if (isHit(mouseX, mouseY, 0, 0, x, y, full.width, full.height)) {
      image(halo, x, y, halo.width, halo.height);
      if (mousePressed) {
        customer = this;
        gameState = TABLE;
        for (int i = 0; i < foodCount; i++) {
          foods[i].onTableX = customer.tableX[i];
          foods[i].onTableY = customer.tableY[i];
          println(foods[i].onTableX, foods[i].onTableY);
        }
        for (int i = 0; i < 7; ++i) {
          if (order[i] != -1 ) {
            switch (order[i]) {
            case BURGER :
              foods[i] = new Burger();
              break;
            case FRENCH_FRIES :
              foods[i] = new FrenchFries();
              break;  
            case ICE_CREAM :
              foods[i] = new IceCream();
              break;  
            case DRINK :
              foods[i] = new Drink();
              break;
            default :
              foods[i] = new Food();
              break;
            }
          }
        }
      }
    } else {
      image(full, x, y, full.width, full.height);
    }
  }

  void halfDisplay() {
    imageMode(CENTER);
    image(half, 350, 150, half.width, half.height);
  }

  void setOrder(int[] order) {
    this.order = order;
    for (int i = 0; i < 7; ++i) {
      if (order[i] != -1) {
        foodCount ++;
      }
    }
  }

  void setTable() {
    switch (foodCount) {
    case 2 :
      tableX[0] = width/3;
      tableY[0] = 500;
      tableX[1] = width/3*2;
      tableY[1] = 500;
      break;  
    case 3 :
      tableX[0] = width/3;
      tableY[0] = 400;
      tableX[1] = width/3*2;
      tableY[1] = 400;
      tableX[2] = width/3;
      tableY[2] = 600;
      tableX[3] = width/3*2;
      tableY[3] = 600;
      break;  
    case 7 :
      tableX[0] = width/4;
      tableY[0] = 400;
      tableX[1] = width/4*2;
      tableY[1] = 400;
      tableX[2] = width/4*3;
      tableY[2] = 400;
      tableX[3] = width/5;
      tableY[3] = 600;
      tableX[4] = width/5*2;
      tableY[4] = 600;
      tableX[5] = width/5*3;
      tableY[5] = 600;
      tableX[6] = width/5*4;
      tableY[6] = 600;
      break;
    }
  }
}