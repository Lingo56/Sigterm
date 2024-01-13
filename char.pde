/*
Class representing every game character (enemy/player)
 */
class MyCharacter {
  PVector position;
  PVector velocity = new PVector(0, 0);
  boolean alreadyHit;
  float maxVel;
  float health;
  float maxHealth;
  float charWidth;
  float charHeight;

  MyCharacter(PVector position) {
    this.position = new PVector(position.x, position.y);
    charWidth = 50;
    charHeight = charWidth;
    maxVel = 10;
    health = 100;
    maxHealth = health;
    alreadyHit = false;
  }

  MyCharacter() {
    this(new PVector(width/2, height/2));
  }

  void update() {
    moveCharacter();
    checkWalls();
  }

  void moveCharacter() {
    if (velocity.mag() > maxVel) {
      position.add(velocity.setMag(maxVel));
    } else {
      position.add(velocity);
    }
  }

  void accelerate(PVector acc) {
    velocity.add(acc);
  }

  void drawCharacter() {
    circle(position.x, position.y, charWidth);
  }

  void decreaseHealth(int amount) {
    health -= amount;
  }

  void checkWalls() {
    if (position.x<charWidth/2) position.x=charWidth/2;
    if (position.x>width-charWidth/2) position.x=width-charWidth/2;
    if (position.y<charHeight/2) position.y=charHeight/2;
    if (position.y>height-charHeight/2) position.y=height-charHeight/2;
  }

  boolean detectHit(MyCharacter c) {
    if ((this.boundingBox().intersects(c.boundingBox()) || c.boundingBox().intersects(this.boundingBox())) && !alreadyHit) {
      alreadyHit = true;
      return true;
    } else if (!(this.boundingBox().intersects(c.boundingBox()) || c.boundingBox().intersects(this.boundingBox()))) {
      alreadyHit = false;
      return false;
    } else {
      return false;
    }
  }

  Rectangle boundingBox() {
    return new Rectangle((int) position.x - (int) charWidth/2, (int) position.y - (int) charHeight/2, (int) charWidth, (int) charHeight);
  }

  void drawBoundingBox(Rectangle r) {
    noFill();
    rect(r.x + r.width/2, r.y + r.height/2, r.width/2, r.height/2);
    fill(255);
  }
}
