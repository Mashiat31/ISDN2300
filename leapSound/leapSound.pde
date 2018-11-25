import processing.sound.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

SoundFile file0;
SoundFile file1;
SoundFile file2;
SoundFile file3;
SoundFile file4;

BandPass bp0;
BandPass bp1;
BandPass bp2;
BandPass bp3;
BandPass bp4;

int minHeight = 0;
int maxHeight = 500;

void leapOnInit() {
  println("Leap Motion Init");
}
void leapOnConnect() {
  println("Leap Motion Connect");
}
void leapOnFrame() {
  //println("Leap Motion Frame");
}
void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
void leapOnExit() {
  println("Leap Motion Exit");
}


void setup() {
  size(800, 500);
  background(255);
  
  leap = new LeapMotion(this);

  file0 = new SoundFile(this, "MGMT - Me and Michael.mp3");
  file1 = new SoundFile(this, "MGMT - Me and Michael.mp3");
  file2 = new SoundFile(this, "MGMT - Me and Michael.mp3");
  file3 = new SoundFile(this, "MGMT - Me and Michael.mp3");
  file4 = new SoundFile(this, "MGMT - Me and Michael.mp3");
  
  bp0 = new BandPass(this);
  bp1 = new BandPass(this);
  bp2 = new BandPass(this);
  bp3 = new BandPass(this);
  bp4 = new BandPass(this);

  bp0.process(file0, 62, 125);
  bp1.process(file1, (500 - 125) / 2 + 125, 500 - 125);
  bp2.process(file2, (2000 - 500) / 2 + 500, 2000 - 500);
  bp3.process(file3, (8000 - 2000) / 2 + 2000, 8000 - 2000);
  bp4.process(file4, (20000 - 8000) / 2 + 8000, 20000 - 8000);

  //file0.amp(0);
  //file1.amp(0);
  //file2.amp(0);
  //file3.amp(0);
  //file4.amp(0);

  file0.play();
  file1.play();
  file2.play();
  file3.play();
  file4.play();
}      

void draw() {
  
  if(leap.countHands() == 1) {
    
    float amp = map(;
    
    file0.amp(0);
    file1.amp(0);
    file2.amp(0);
    file3.amp(0);
    file4.amp(0);
  }
  
}
