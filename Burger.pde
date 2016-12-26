import java.util.*;
class Burger extends Food {
  Ingredients[] igds = new Ingredients[6]; //上面的食材
  int x; //conveyor's x
  int conveyorSpeed=5;
  List<Ingredients> burger = new ArrayList<Ingredients>(); //random 漢堡
  Ingredients falling;
  boolean igdFalling = false;
  Ingredients[] player = new Ingredients[6]; //建造中的漢堡
  int n = -1; //第幾層漢堡
  float CenterOfGravity; //重心

  Burger () {
    //burger
    //btmbread = loadImage("img/burger/btmbread.png");
    //middlebread = loadImage("img/burger/middlebread.png");
    //topbread = loadImage("img/burger/topbread.png");
    //cheese = loadImage("img/burger/cheese.png");
    //lettuce = loadImage("img/burger/lettuce.png");
    //meat = loadImage("img/burger/meat.png");
    //tomato = loadImage("img/burger/tomato.png");
    //conveyor = loadImage("img/burger/conveyor.png");
    //conveyorGlass = loadImage("img/burger/conveyor_glass.png");

    igds[0] = new Ingredients("middlebread");
    igds[1] = new Ingredients("topbread");
    igds[2] = new Ingredients("cheese");
    igds[3] = new Ingredients("lettuce");
    igds[4] = new Ingredients("meat");
    igds[5] = new Ingredients("tomato");

    for (int i=0; i<6; i++) {
      igds[i].xSpeed = conveyorSpeed;
      igds[i].x =-250-250*i;
      igds[i].y=100;
    }
    
    randomBurger();
  }

void randomBurger() {
  burger.add(new Ingredients("cheese"));
  burger.add(new Ingredients("lettuce"));
  burger.add(new Ingredients("meat"));
  burger.add(new Ingredients("tomato"));
  Collections.shuffle(burger);
  burger.add(new Ingredients("topbread"));
  burger.add(2, new Ingredients("middlebread"));
  burger.add(0, new Ingredients("btmbread"));
}

  void showFinished(float x, float y){
    imageMode(CENTER);
    for (int i = 0; i < burger.size(); i++) {
      image(burger.get(i).img, x+100, y+20*(8-i), 200, 100);
    }
  }

  void showFinished(float x, float y, float w, float h){
    imageMode(CENTER);
    for (int i = 0; i < burger.size(); i++) {
      image(burger.get(i).img, x+w/2, y+(h/20)+(h/20)*(7-i), w, (h/4));
    }
  }

  void conveyorDisplay(){


  }
}