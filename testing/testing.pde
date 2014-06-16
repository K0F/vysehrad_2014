

void setup(){

    size(1280,720,P2D);


}

/*
void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();

}
*/


void draw(){

    if(frameCount<10)
      frame.setLocation(1920,0);

    background(0);


/*
    noStroke();


    stroke(255);
    for(int i = 0;i<width;i+=20){
      line(i,0,i,height);
    }
  */  
    
    fill(255);

    float shift = sin(frameCount/100.0)*100.0;

    noStroke();
    ellipse(width/2,height/2-shift,20*28.5,20*28.5);


    println(shift);

}
