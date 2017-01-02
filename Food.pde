class Food {
  PImage bg;
  PImage finished, gray;
  boolean done;
  int type;
  float onTableX;
  float onTableY;
  int index;

  Food() {}

  void displayOnTable() {
    if (done) {
      showFinished(onTableX, onTableY);
    } else {
      showGray(onTableX, onTableY);
    }
  }
  
  void showGray(float x, float y) {}
  void showFinished(float x, float y) {}
  void display() {}
  
  void mousePressed() {
  }
  void mouseReleased() {
  }
  void keyPressed() {
  }
  void keyReleased() {
  }
}