class Food {
  PImage bg;
  PImage finished, gray;
  boolean done = false;
  int type;
  float onTableX;
  float onTableY;

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