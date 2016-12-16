class Person{
  int[] order = new int[7];
  int foodCount;
  PImage full;
  PImage halo;
  PImage half;
  int[] tableX;
  int[] tableY;
  
  Person(){}
  
  Person(String who){
    full = loadImage("img/people/" + who + ".png");
    halo = loadImage("img/people/" + who + "Halo.png");
    half = loadImage("img/people/" + who + "Half.png");
    for (int i = 0; i < 7; ++i) {
      order[i] = -1;
    }
  }

  void fullDisplay(int x, int y){
    imageMode(CORNER);
    if (isHit(mouseX, mouseY, 0, 0, x, y, full.width, full.height)) {
      image(halo, x , y, halo.width, halo.height);
      if (mousePressed) {
        customer = this;
        gameState = TABLE;
        for (int i = 0; i < foodCount; ++i) {
          switch (order[i]) {
            case BURGER :
              foods[i] = new Burger();
            break; 
          }
        }
      }
    } else {
      image(full, x , y, full.width, full.height);
    }
  }

  void halfDisplay(){
    imageMode(CENTER);
    image(half, 350, 150, half.width, half.height);
  }

  void setOrder(int[] order){
    this.order = order;
  }
  
  void setTable(){
    for (int i = 0; i < 7; ++i) {
      if (order[i] != -1) {
        foodCount ++;
      }
    }
    
    if (foodCount > 3) { //teacher is customer
      for (int i = 0; i < foodCount; i++) {
        if (i < 3) {
          int axisX1 = width / 4;
          tableX[i] = axisX1*(i+1); 
          tableY[i] = 400;
        }else{
          int axisX2 = width / 5;
          tableX[i] = axisX2*(i+1); 
          tableY[i] = 600;
        }
      }
    }else{ //TA is customer
      int axisX = width / (foodCount+1);
      for (int i = 0; i < foodCount; i++) {
        tableX[i] = axisX*(i+1); 
        tableY[i]= 500;
      }
    }
  }
}