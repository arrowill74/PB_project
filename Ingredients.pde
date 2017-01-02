class Ingredients {
  PImage img;
  int x, y, xSpeed, ySpeed;
  String name;

  Ingredients(){}
  
  Ingredients(String name) {
    img = loadImage("img/burger/"+name+".png"); 
    this.name = name;
    ySpeed = 10;
  }

  void display() {    
    image(img, x, y);
  }

  void move() {
    x += xSpeed;
    if (x>750) {
      x=-750;
      y=100;
    }
  }

  void falling() {
    y+=ySpeed;
  }

  void disappear() {
    y=-1000;
  }
}