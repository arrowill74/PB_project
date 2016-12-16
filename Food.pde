class Food{
	PImage raw;
	PImage finished;
  PImage check;
	boolean done = false;
	int type;
  int onTableX;
  int onTableY;
  
  Food(){
  }
  
	void displayOnTable(int x, int y){
     imageMode(CENTER);
     if(done == true){
       image(finished, x, y);
       image(check, x, y);
     }else{
       image(raw, x, y);
     }
	}

}