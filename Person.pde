class Person {
  int[] order;
  PImage full;
  PImage halo;
  PImage half;
  float[] tableX = new float[7];
  float[] tableY = new float[7];
  int foodCount = 0;

  Person() {
  }

  Person(String who) {
    full = loadImage("img/people/" + who + ".png");
    halo = loadImage("img/people/" + who + "Halo.png");
    half = loadImage("img/people/" + who + "Half.png");
  }

  void fullDisplay(int x, int y) {
    imageMode(CORNER);
    if (isHit(mouseX, mouseY, 0, 0, x, y, full.width, full.height)) {
      image(halo, x, y, halo.width, halo.height);
      if (mousePressed) {
        customer = this;
        gameState = TABLE;
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
    switch (foodCount) {
      case 2 :
        tableX[0] = width/3;
        tableY[0] = 500;
        tableX[1] = width/3*2;
        tableY[1] = 500;
      break;  
      case 4 :
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
        tableX[1] = width/5*2;
        tableY[1] = 600;
        tableX[2] = width/5*3;
        tableY[2] = 600;
        tableX[3] = width/5*4;
        tableY[3] = 600;
      break;  
    }
  }
}