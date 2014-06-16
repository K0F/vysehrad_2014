/**
 * 224.0.0.0 - 224.0.0.255 Reserved for special well-known multicast addresses.
 * 224.0.1.0 - 238.255.255.255 Globally-scoped (Internet-wide) multicast addresses.
 * 239.0.0.0 - 239.255.255.255 Administratively-scoped (local) multicast addresses.
 */

import oscP5.*;
import netP5.*;
import java.io.*;

OscP5 oscP5;

String text = "Vyšehrad v dějinách\npražského opevnění";

void setup() {
  size(1920,1080,P2D);
  frameRate(20);
  oscP5 = new OscP5(this,"239.0.0.1",7777);

  textFont(createFont("Capsuula", 72, true));

  textAlign(CENTER,CENTER);
}

boolean snd,rcv;


void init(){

  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();
}

void draw() {

  if(frameCount<5){
    frame.setLocation(0,0);
  }

  background(0);
  //stroke(255);
  //noFill();
  //rect(1,1,width-2,height-2);



  fill(#ffcc00,127.0*(sin(frameCount/10.0)+1.0));
  noStroke();
  rect(1,1,5,5);

  if(rcv){
    fill(#00ff00); 
    rect(5,1,5,5);
    rcv = false;
  }

  if(snd){
    fill(#ff0000); 
    rect(10,1,5,5);
    snd = false;
  }


  //testing only
  fill(255);
  ellipse(width/2,height/2,550,550);

  fill(0);
  text(text,width/2,height/2);
}

String s = "";

void runS(String _cmd){

  s = "";

  try {

    Process p = Runtime.getRuntime().exec(_cmd);



    /*
       BufferedReader stdInput = new BufferedReader(new 
       InputStreamReader(p.getInputStream()));

       BufferedReader stdError = new BufferedReader(new 
       InputStreamReader(p.getErrorStream()));
    // read the output from the command
    System.out.println("Here is the standard output of the command:\n");
    while ((s = stdInput.readLine()) != null) {
    System.out.println(s);
    }

    // read any errors from the attempted command
    System.out.println("Here is the standard error of the command (if any):\n");
    while ((s = stdError.readLine()) != null) {
    System.out.println(s);
    }
     */          
    //System.exit(0);
  }
  catch (IOException e) {
    System.out.println("exception happened - here's what I know: ");
    e.printStackTrace();
    //System.exit(-1);
  }
}


void reply() {
  snd = true;
  OscMessage myOscMessage = new OscMessage("/test");
  myOscMessage.add(100);
  oscP5.send(myOscMessage);
}

void stop(){
  runS("/home/kof/vysehrad/clean.sh");
  super.stop();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  rcv = true;


  if(theOscMessage.addrPattern().equals("/control/start")){
    runS("masskill mplayer");
    runS("rm /tmp/ctl");
    runS("mkfifo /tmp/ctl");


    if(theOscMessage.get(0).intValue()==1){
      runS("mplayer  -fixed-vo -vo x11 -osdlevel 0 -slave -input file=/tmp/ctl -geometry 1920x1080+0+0 -quiet /home/kof/1.mp4");
      runS("mplayer  -fixed-vo -vo x11 -osdlevel 0 -slave -input file=/tmp/ctl -geometry 1280x720+1920+0 -quiet /home/kof/2.mp4");
    }else if(theOscMessage.get(0).intValue()==2){

      runS("mplayer  -fixed-vo -vo x11 -osdlevel 0 -slave -input file=/tmp/ctl -geometry 1920x1080+0+0 -quiet /home/kof/3.mp4");
      runS("mplayer  -fixed-vo -vo x11 -osdlevel 0 -slave -input file=/tmp/ctl -geometry 1280x720+1920+0 -quiet /home/kof/4.mp4");


    }
  }

  if(theOscMessage.addrPattern().equals("/control/move")){
    runS(sketchPath+"/move "+theOscMessage.get(0).intValue());
  }

  if(theOscMessage.addrPattern().equals("/control/exit")){
    runS("masskill mplayer");
    //stop();
  }


  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
