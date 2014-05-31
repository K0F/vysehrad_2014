/**
 * oscP5multicast by andreas schlegel
 * example shows how to send osc via a multicast socket.
 * what is a multicast? http://en.wikipedia.org/wiki/Multicast
 * ip multicast ranges and uses:
 * 224.0.0.0 - 224.0.0.255 Reserved for special �well-known� multicast addresses.
 * 224.0.1.0 - 238.255.255.255 Globally-scoped (Internet-wide) multicast addresses.
 * 239.0.0.0 - 239.255.255.255 Administratively-scoped (local) multicast addresses.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

Button one;

void setup() {
  size(1024,600);
  frameRate(25);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this,"239.0.0.1",7777);
  
  
  one = new Button(1,"Video 1",100,100,200,20);
  
  
  
  textFont(createFont("SempliceRegular.ttf",9,false));
  
}


void draw() {
  background(0);
  
  one.draw();
}

void startVideo(int num){
  OscMessage myOscMessage = new OscMessage("/control/start");
  myOscMessage.add(num);
  oscP5.send(myOscMessage);
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
