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

int minHeight = 300;
int maxHeight = 500;
int maxFingerLength = 70;

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

  file0 = new SoundFile(this, "M83 - Bibi The Dog (Audio).mp3");
  file1 = new SoundFile(this, "M83 - Bibi The Dog (Audio).mp3");
  file2 = new SoundFile(this, "M83 - Bibi The Dog (Audio).mp3");
  file3 = new SoundFile(this, "M83 - Bibi The Dog (Audio).mp3");
  file4 = new SoundFile(this, "M83 - Bibi The Dog (Audio).mp3");
  
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
  drawBackground();
  
  system.update();
  
  
  
  if(leap.countHands() == 1) {
    
    for (Hand hand : leap.getHands ()) {
      PVector handPosition = hand.getPosition();
      float[] palmFloat = handPosition.array();      
      float amp = map(palmFloat[1], minHeight, maxHeight, 1, 0);
      amp = constrain(amp, 0, 1);
      println("total amplitude : ", amp);
      
      Finger finger = hand.getThumb();
      PVector fingerPosition = finger.getPosition();
      float[] fingerFloat = fingerPosition.array();
      float bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file0.amp(bandAmp);
      println("thumb amplitude : ", bandAmp);
      
      finger = hand.getIndexFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file1.amp(bandAmp);
      println("index amplitude : ", bandAmp);
      
      finger = hand.getMiddleFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file2.amp(bandAmp);
      println("mid f amplitude : ", bandAmp);
      
      finger = hand.getRingFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file3.amp(bandAmp);
      println("ring  amplitude : ", bandAmp);
      
      finger = hand.getPinkyFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file4.amp(bandAmp);
      println("pinky amplitude : ", bandAmp);
    }
    
  } else {
    //file0.amp(0);
    //file1.amp(0);
    //file2.amp(0);
    //file3.amp(0);
    //file4.amp(0);
  }
  
}
