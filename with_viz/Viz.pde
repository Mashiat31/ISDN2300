import java.util.Iterator;

final float GRAVITY = -0.1;
final boolean MOTION_BLUR = true;

ParticleSystem system = new ParticleSystem();

/*void setup()
{
  size(1000, 1000);  
  background(0);
}
*/
/*void draw()
{
  drawBackground();
  
  system.update();
}*/

void mouseDragged()
//convert to leap motion

{ 
  system.particles.add(new Particle(new PVector(mouseX, mouseY)));
  system.particles.add(new Particle(new PVector(mouseX, mouseY)));
  system.particles.add(new Particle(new PVector(mouseX, mouseY)));
  system.particles.add(new Particle(new PVector(mouseX, mouseY)));
}

void drawBackground()
{
  if (MOTION_BLUR) {
    // Background with motion blur
    noStroke();
    fill(0, 20);
    rect(0, 0, width, height);
  } else {
    // Normal background
    background(0);
  }
}

class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  void update()
  {
    Iterator<Particle> i = particles.iterator();

    while (i.hasNext()) {
      Particle p = i.next();
      
      // Remove any particles outside of the screen
      if (p.pos.x > width || p.pos.x < 0) {
        i.remove();
        continue;
      } else if (p.pos.y > height || p.pos.y < 0) {
        i.remove();
        continue;
      }
      
      // Apply gravity
      p.applyForce(new PVector(0, GRAVITY));
      
      // Move particle position
      p.move();
      
      if (p.isDead()) {
        i.remove();  
      } else {
        p.display();
      }
      
    }
  }
}

class Particle
{
  final static float BOUNCE = -0.5;
  final static float MAX_SPEED = 0.1;
  
  PVector vel = new PVector(random(-MAX_SPEED, MAX_SPEED), random(-MAX_SPEED, MAX_SPEED));
  PVector acc = new PVector(0, 0);
  PVector pos;
  
  float mass = random(2, 2.5);
  float size = random(0.1, 2.0);
  float r, g, b;
  int lifespan = 255;
  
  Particle(PVector p)
  {
    pos = new PVector (p.x, p.y);
    acc = new PVector (random(0.1, 1.5), 0);
    r = random (100, 255);
    g = random (0, 50);
    b = 0;
  }
  
  public void move()
  {
    vel.add(acc); //  acceleration
    pos.add(vel); // our speed vector
    acc.mult(0);
    
    size += 0.01; //0.015
    lifespan--;
  }
  
  public void applyForce(PVector force) 
  {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  public void display()
  {
    fill(r, g, b, lifespan);
    
    ellipse(pos.x, pos.y, size * 4, size * 4);
  }
  
  public boolean isDead()
  {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}
