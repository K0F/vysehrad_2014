/**
 * 224.0.0.0 - 224.0.0.255 Reserved for special well-known multicast addresses.
 * 224.0.1.0 - 238.255.255.255 Globally-scoped (Internet-wide) multicast addresses.
 * 239.0.0.0 - 239.255.255.255 Administratively-scoped (local) multicast addresses.
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

int H = 60;

ArrayList buttons;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  size(displayWidth, displayHeight,P2D);
  frameRate(25);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this, "239.0.0.1", 7777);


  buttons = new ArrayList();
  buttons.add(new Button(1, "Video 1", 100, 100, 200, H));
  buttons.add(new Button(2, "Video 2", 100, 200, 200, H));
  buttons.add(new Button(3, "Video 3", 100, 300, 200, H));
  buttons.add(new Button(4, "Video 4", 100, 400, 200, H));
  
  
  buttons.add(new Button(5, "kill video", 500, 400, 200, H));



  textFont(createFont("SempliceRegular.ttf", 9, false));
}


void draw() {
  background(0);
  for (Object o: buttons) {
    Button tmp = (Button)o;
    tmp.draw();
  }
}

void startVideo(int num) {
  OscMessage myOscMessage = new OscMessage("/control/start");
  myOscMessage.add(num);
  oscP5.send(myOscMessage);
}

void killSignal() {
  OscMessage myOscMessage = new OscMessage("/control/exit");
  myOscMessage.add(num);
  oscP5.send(myOscMessage);
}


void mousePressed() {
  for (Object o: buttons) {
    Button tmp = (Button)o;
    tmp.over();
  }
}

/*
void mousePressed() {
 
 OscMessage myOscMessage = new OscMessage("/control/move");
 
 myOscMessage.add((int)map(mouseX,0,width,0,100)); 
 oscP5.send(myOscMessage);
 }
 */


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}

