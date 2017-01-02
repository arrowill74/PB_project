class Blood {
  PImage img, img0;
  int index;
  
  Blood(String mood, int i) {
    img = loadImage("img/blood/"+mood+".png");
    img0 = loadImage("img/blood/"+mood+"0.png");
    index = i;
  }
  
  void display(int curblood){
    imageMode(CORNER);
    if(index < curblood){
      image(img, 10+index*40, 10);
    }else{
      image(img0, 10+index*40, 10);
    }
  }
}