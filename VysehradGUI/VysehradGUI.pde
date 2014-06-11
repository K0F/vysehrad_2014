/**
 * 224.0.0.0 - 224.0.0.255 Reserved for special well-known multicast addresses.
 * 224.0.1.0 - 238.255.255.255 Globally-scoped (Internet-wide) multicast addresses.
 * 239.0.0.0 - 239.255.255.255 Administratively-scoped (local) multicast addresses.
 */

import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;

import oscP5.*;
import netP5.*;


float VIDEO_LENGTH = 1000*60*6;

OscP5 oscP5;

int H = 60;

boolean playing = false;

ArrayList buttons;

float start = 0;
float pos = 0;

@Override
public void onCreate(Bundle savedInstanceState) {
 super.onCreate(savedInstanceState);

  getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
}


void setup() {
  size(displayWidth, displayHeight,P2D);
  
  frameRate(25);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this, "239.0.0.1", 7777);


  buttons = new ArrayList();
  buttons.add(new Button(1, "ČS", width/3, 300, 250, H));
  buttons.add(new Button(2, "EN", width/3*2, 300, 250, H));
  //buttons.add(new Button(3, "Video 3", 100, 300, 200, H));
  //buttons.add(new Button(4, "Video 4", 100, 400, 200, H));
  
  
  buttons.add(new Button(5, "X", 900, 100, 100, H));



  textFont(createFont("Capsuula.ttf", 72, true));
  
  textAlign(CENTER,CENTER);
}


void draw() {
  background(0);
  noStroke();
  for (Object o: buttons) {
    Button tmp = (Button)o;
    tmp.draw();
  }
  
  if(playing){
  
  pos = map(millis()-start,0,VIDEO_LENGTH,0,width/3+250/2);
  pos = constrain(pos,0,width/3+250/2);
  
  fill(55);
  rect(width/3-250/4,450,width/3+250/2,20);
  fill(255);
  rect(width/3-250/4,450,pos,20);
  }
}

void startVideo(int num) {
  OscMessage myOscMessage = new OscMessage("/control/start");
  myOscMessage.add(num);
  oscP5.send(myOscMessage);
}

void moveVideo(int pos){
  OscMessage myOscMessage = new OscMessage("/control/move");
  myOscMessage.add(pos);
  oscP5.send(myOscMessage);
}

void killSignal() {
  OscMessage myOscMessage = new OscMessage("/control/exit");
  myOscMessage.add(1);
  oscP5.send(myOscMessage);
}


boolean sliderOver(){
  if(mouseX>width/3-250/4 && mouseY > 450 && mouseX < width/3-250/4+width/3+250/2 && mouseY < 450+20)
  return true;
  else
  return false;
}

void mousePressed() {
  for (Object o: buttons) {
    Button tmp = (Button)o;
    tmp.over();
  }
  /*
  if(sliderOver()){
    start = millis()-map(mouseX,width/3+250/4,width/3+250/4+width/3+250/2,0,VIDEO_LENGTH);
    float ms = map(start,0,VIDEO_LENGTH,0,100);
    moveVideo((int)ms); 
  }
  */
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

