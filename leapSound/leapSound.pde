import processing.sound.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

//prog param
String leftAudio = "M83 - Bibi The Dog (Audio) Left.mp3";
String rightAudio = "M83 - Bibi The Dog (Audio) Right.mp3";
int binNo = 1024;
float smoothing = 0.3;

SoundFile file0;          //audio streams
SoundFile file1;
SoundFile file2;
SoundFile file3;
SoundFile file4;
SoundFile file5;
SoundFile file6;
SoundFile file7;
SoundFile file8;
SoundFile file9;

BandPass bp0;              //bandpass filters
BandPass bp1;
BandPass bp2;
BandPass bp3;
BandPass bp4;
BandPass bp5;
BandPass bp6;
BandPass bp7;
BandPass bp8;
BandPass bp9;

AudioIn in0;

FFT fft0;                  //FFT instances

float[] bin0 = new float[binNo];  //FFT bins
float[] sum0 = new float[binNo];

int minHeight = 200;        //minimum vertical diatance between hand and LM
int maxHeight = 450;        //maximum vertical diatance between hand and LM
int maxFingerLength = 70;   //maximum vertical distance between finger tip and palm

//Interupt callbacks
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
  size(512, 512);
  background(255);
  
  leap = new LeapMotion(this);

  file0 = new SoundFile(this, leftAudio);
  file1 = new SoundFile(this, leftAudio);
  file2 = new SoundFile(this, leftAudio);
  file3 = new SoundFile(this, leftAudio);
  file4 = new SoundFile(this, leftAudio);
  
  file5 = new SoundFile(this, rightAudio);
  file6 = new SoundFile(this, rightAudio);
  file7 = new SoundFile(this, rightAudio);
  file8 = new SoundFile(this, rightAudio);
  file9 = new SoundFile(this, rightAudio);
  
  bp0 = new BandPass(this);
  bp1 = new BandPass(this);
  bp2 = new BandPass(this);
  bp3 = new BandPass(this);
  bp4 = new BandPass(this);
  
  bp5 = new BandPass(this);
  bp6 = new BandPass(this);
  bp7 = new BandPass(this);
  bp8 = new BandPass(this);
  bp9 = new BandPass(this);

  bp0.process(file0, 62, 125);
  bp1.process(file1, (500 - 125) / 2 + 125, 500 - 125);
  bp2.process(file2, (2000 - 500) / 2 + 500, 2000 - 500);
  bp3.process(file3, (8000 - 2000) / 2 + 2000, 8000 - 2000);
  bp4.process(file4, (20000 - 8000) / 2 + 8000, 20000 - 8000);
  
  bp5.process(file5, 62, 125);
  bp6.process(file6, (500 - 125) / 2 + 125, 500 - 125);
  bp7.process(file7, (2000 - 500) / 2 + 500, 2000 - 500);
  bp8.process(file8, (8000 - 2000) / 2 + 2000, 8000 - 2000);
  bp9.process(file9, (20000 - 8000) / 2 + 8000, 20000 - 8000);

  file0.play();
  file1.play();
  file2.play();
  file3.play();
  file4.play();
  
  file5.play();
  file6.play();
  file7.play();
  file8.play();
  file9.play();
  
  fft0 = new FFT(this, binNo);  
  in0 = new AudioIn(this, 0);
  in0.start();
  fft0.input(in0);

}      

void draw() {
  
  //background(100);
  //stroke(100);
  //noFill();
  //fft0.analyze(bin0);
  //int r = 256;
  //int lp = 100;
  //int hp = 800;
  //float d = TWO_PI / (binNo - (lp + hp));
  //beginShape();
  //float x;
  //float y;
  //float fftamp;
  //for (int i = 0; i < binNo - lp - hp; i++) {         
    
  //  sum0[i] += (bin0[i] - sum0[i]) * smoothing;
    
  //  fftamp = map(sum0[i + lp], 0, 255, 100, r);
    
  //  x = cos(i * d) * fftamp;
  //  y = sin(i * d) * fftamp;
    
  //  vertex(x + width / 2, y + height / 2);
  //}
  //endShape(CLOSE);
  
  if(leap.countHands() == 1) {
    
    for (Hand hand : leap.getHands ()) {
      PVector handPosition = hand.getPosition();
      float[] palmFloat = handPosition.array();      
      float amp = map(palmFloat[1], minHeight, maxHeight, 0, 1);
      amp = constrain(amp, 0, 1);
      println("total amplitude : ", amp);
      
      Finger finger = hand.getThumb();
      PVector fingerPosition = finger.getPosition();
      float[] fingerFloat = fingerPosition.array();
      float bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file0.amp(bandAmp);
      file5.amp(bandAmp);
      println("thumb amplitude : ", bandAmp);
      
      finger = hand.getIndexFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file1.amp(bandAmp);
      file6.amp(bandAmp);
      println("index amplitude : ", bandAmp);
      
      finger = hand.getMiddleFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file2.amp(bandAmp);
      file7.amp(bandAmp);
      println("mid f amplitude : ", bandAmp);
      
      finger = hand.getRingFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file3.amp(bandAmp);
      file8.amp(bandAmp);
      println("ring  amplitude : ", bandAmp);
      
      finger = hand.getPinkyFinger();
      fingerPosition = finger.getPosition();
      fingerFloat = fingerPosition.array();
      bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
      bandAmp = constrain(bandAmp, 0, 1) * amp;
      file4.amp(bandAmp);
      file9.amp(bandAmp);
      println("pinky amplitude : ", bandAmp);
      
      fft0.analyze(bin0);
      
    }
    
  } else {
    
    if (leap.countHands() == 2) {
     
      for (Hand hand : leap.getHands ()) {
        
        if (hand.isLeft()) {
          
            PVector handPosition = hand.getPosition();
            float[] palmFloat = handPosition.array();      
            float amp = map(palmFloat[1], minHeight, maxHeight, 0, 1);
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
            
          } else {
            
            PVector handPosition = hand.getPosition();
            float[] palmFloat = handPosition.array();      
            float amp = map(palmFloat[1], minHeight, maxHeight, 0, 1);
            amp = constrain(amp, 0, 1);
            println("total amplitude : ", amp);
            
            Finger finger = hand.getThumb();
            PVector fingerPosition = finger.getPosition();
            float[] fingerFloat = fingerPosition.array();
            float bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
            bandAmp = constrain(bandAmp, 0, 1) * amp;
            file5.amp(bandAmp);
            println("thumb amplitude : ", bandAmp);
            
            finger = hand.getIndexFinger();
            fingerPosition = finger.getPosition();
            fingerFloat = fingerPosition.array();
            bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
            bandAmp = constrain(bandAmp, 0, 1) * amp;
            file6.amp(bandAmp);
            println("index amplitude : ", bandAmp);
            
            finger = hand.getMiddleFinger();
            fingerPosition = finger.getPosition();
            fingerFloat = fingerPosition.array();
            bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
            bandAmp = constrain(bandAmp, 0, 1) * amp;
            file7.amp(bandAmp);
            println("mid f amplitude : ", bandAmp);
            
            finger = hand.getRingFinger();
            fingerPosition = finger.getPosition();
            fingerFloat = fingerPosition.array();
            bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
            bandAmp = constrain(bandAmp, 0, 1) * amp;
            file8.amp(bandAmp);
            println("ring  amplitude : ", bandAmp);
            
            finger = hand.getPinkyFinger();
            fingerPosition = finger.getPosition();
            fingerFloat = fingerPosition.array();
            bandAmp = map(fingerFloat[1], palmFloat[1], palmFloat[1] + maxFingerLength, 1, 0);
            bandAmp = constrain(bandAmp, 0, 1) * amp;
            file9.amp(bandAmp);
            println("pinky amplitude : ", bandAmp);            
          }
          
        }
        
      }
      
    }
    
}
  
