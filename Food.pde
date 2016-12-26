class Food {
  PImage check;
  boolean done = false;
  int type;
  float onTableX;
  float onTableY;

  Food() {
  }

  void displayOnTable() {
   if (done == true) {
     showFinished(onTableX, onTableY);
     image(check, onTableX, onTableY);
   } else {
     showFinished(onTableX, onTableY);
   }
  }

  void showFinished(float x, float y){}
}