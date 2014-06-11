

class Button {
  String name;
  PVector pos;
  boolean state;
  boolean over;
  int id;
  int w, h;
  float sfade, fade;

  Button(int _id, String _name, int _x, int _y, int _w, int _h) {
    id = _id;
    name = _name+"";
    w = _w;
    h = _h;
    pos = new PVector(_x, _y);
    sfade = fade = 0.0;
  }

  void trigger() {
    sfade = fade = 1.0;
    if(id<=4){
    startVideo(id);
    }else{
     if(id==5)
      killSignal(); 
    }
  }

  void draw() {
    

    fade *= 0.9;
    sfade += (fade - sfade) / 5.0;

    fill(lerpColor(#444444, #ffffff, sfade));


    noStroke();
    ellipse(pos.x, pos.y, w/2, w/2); 

    fill(255);

    text(name, pos.x, pos.y);
  }

  boolean over() {
    if (dist(mouseX,mouseY,pos.x,pos.y) < w/2) {
      trigger();
      if(id==1||id==2){
        start = millis();
        playing = true;
      }else{
        playing = false; 
      }
      return true;
    }
    else {
      
      return false;
    }
  }
}

