


void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();

}

void setup(){

    size(1280,720);


}



void draw(){

    if(frameCount==0)
      frame.setLocation(0,0);

    background(0);



    noStroke();
    fill(255);
    ellipse(width/2,height/2,200,200);


}
