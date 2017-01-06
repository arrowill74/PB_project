class Food {
  PImage bg, intro, startBtn, finBtn, againbtn;
  PImage finished, gray;
  boolean done;
  int type;
  float onTableX;
  float onTableY;
  int index;
  int state;
  final int INTRO = 0;
  final int PLAY = 1;
  final int FINISH = 2;

  Food() {
  }

  void displayOnTable() {
    if (done) {
      showFinished(onTableX, onTableY);
    } else {
      showGray(onTableX, onTableY);
    }
  }

  void showGray(float x, float y) {
  }
  void showFinished(float x, float y) {
  }
  void display() {
  }

  void bloodChange(boolean ctrl, int plus) {
    if (!ctrl) {
      curblood += plus;
      bloodCtrl = true;
    }
  }

  void mousePressed() {
  }
  void mouseReleased() {
  }
  //void mouseClicked() {
  //}
  void keyPressed() {
  }
  void keyReleased() {
  }
}