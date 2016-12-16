class Ingredients {
  PImage igdImage;
  int x, y, xSpeed, ySpeed;
  String name;

  Ingredients(String name) {
    igdImage = loadImage("img/burger/"+name+".png"); 
    this.name = name;
    xSpeed = conveyorSpeed;
    ySpeed = 10;
  }

  void display() {    
    image(igdImage, x, y);
  }

  void move() {
    x+=xSpeed;
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