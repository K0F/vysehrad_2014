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
import java.io.*;

OscP5 oscP5;

void setup() {
  size(200,200);
  frameRate(25);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this,"239.0.0.1",7777);
}

boolean snd,rcv;

void draw() {
  background(0);
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

}

String s = "";

void runS(String _cmd){

  s = "";

  try {

    // run the Unix "ps -ef" command
    // using the Runtime exec method:
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


void mousePressed() {
  snd = true;
  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage("/test");

  /* add a value (an integer) to the OscMessage */
  myOscMessage.add(100);

  /* send the OscMessage to the multicast group. 
   * the multicast group netAddress is the default netAddress, therefore
   * you dont need to specify a NetAddress to send the osc message.
   */
  oscP5.send(myOscMessage);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  rcv = true;
  if(theOscMessage.addrPattern().equals("/control")){
    runS("masskill mplayer");
    runS("mplayer -geometry 1024x768+0+0 -screenw 1024 -screenh 768 -quiet /home/kof/XFR_2013-07-17_1B_05.mp4");
  }
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
