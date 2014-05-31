

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
    startVideo(id);
  }

  void draw() {
    

    fade *= 0.95;
    sfade += (fade - sfade) / 10.0;

    fill(lerpColor(#ffcc00, #ffffff, sfade));


    rect(pos.x, pos.y, w, h); 

    fill(0);

    text(name, pos.x+5, pos.y+(h/2)+4);
  }

  boolean over() {
    if (mouseX>pos.x&&mouseX<pos.x+w&&mouseY>pos.y&&mouseY<pos.y+h) {
      trigger();
      return true;
    }
    else {
      
      return false;
    }
  }
}

