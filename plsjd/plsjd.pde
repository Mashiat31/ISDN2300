
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput output;
FilePlayer groove;
BandPass   bpf;

 float xmag, ymag = 0;
float newXmag, newYmag = 0; 



void setup()
{
  size(1000, 900, P3D);
  
  minim = new Minim(this);
  output = minim.getLineOut();
  
  groove = new FilePlayer( minim.loadFileStream("Shooting Stars.mp3") );
  
  
  colorMode(RGB, 1); 
  // make a band pass filter with a center frequency of 440 Hz and a bandwidth of 20 Hz
  // the third argument is the sample rate of the audio that will be filtered
  // it is required to correctly compute values used by the filter
  bpf = new BandPass(440, 20, output.sampleRate());
  groove.patch( bpf ).patch( output );
  // start the file playing
  groove.loop();
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < output.bufferSize()-1; i++)
  {
    float x1 = map(i, 0, output.bufferSize(), 0, width);
    float x2 = map(i+1, 0, output.bufferSize(), 0, width);
    fill (255, 0 , 0);
 
 

 

 

  background(0.5);
  
  pushMatrix(); 
  translate(width/2, height/2, -30); 
  
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;
  
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0; 
  }
  
  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0; 
  }
  
  rotateX(-ymag); 
  rotateY(-xmag); 
  
  scale(90);
  beginShape(QUADS);

  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);

  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);
  fill(0, 0, 0); vertex(-1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(0, 1, 1); vertex(-1,  1,  1);

  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  endShape();
  
  popMatrix(); 

  
  //ellipse(x1, height/4 - output.left.get(i)*50, x2, height/4 - output.left.get(i+1)*50);
  //rect (x1, 3*height/4 - output.right.get(i)*50, x2, 3*height/4 - output.right.get(i+1)*50);
  }
  // draw a rectangle to represent the pass band
  noStroke();
  fill(0, 0, 0, 60);
  //translate (width/, height/2);
  rect(mouseX - bpf.getBandWidth()/20, 0, bpf.getBandWidth()/10, height);
  
  
  
  

  
 
}

void mouseMoved()
{
  // map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies
  float passBand = map(mouseX, 0, width, 100, 2000);
  bpf.setFreq(passBand);
  float bandWidth = map(mouseY, 0, height, 50, 500);
  bpf.setBandWidth(bandWidth);
  // prints the new values of the coefficients in the console
  //bpf.printCoeff();
}
