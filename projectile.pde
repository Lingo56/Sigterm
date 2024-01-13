/*
Projectile class
 Holds the logic behind every projectile fired in-game
 */
class Projectile {
  PVector position;
  PVector velocity;
  float size;
  boolean isAlive;
  int damage;
  color fillColor;

  Projectile(PVector spawnPos, PVector initialVel) {
    position = spawnPos;
    velocity = initialVel;
    size = 5;
    damage = 50;
    isAlive = true;
  }

  Projectile(PVector spawnPos, PVector initialVel, int size, float damage, color fillColor) {
    position = spawnPos;
    velocity = initialVel;
    this.size = size;
    this.damage = (int)damage;
    this.fillColor = fillColor; 
    
    isAlive = true;
  }

  void drawProjectile() {
    fill(fillColor);
    strokeWeight(4);
    stroke(0);

    pushMatrix();
    pushMatrix();
    circle(position.x, position.y, size);
    popMatrix();
    popMatrix();
  }

  void move() {
    position.add(velocity);
  }

  boolean hit(MyCharacter c) {
    if (this.boundingBox().intersects(c.boundingBox()) && c.health > 0) {
      c.decreaseHealth(damage);
      isAlive = false;
      return true;
    }
    return false;
  }

  void checkWalls() {
    if (abs(position.x-width/2) > width/2 || abs(position.y-height/2) > height/2) {
      isAlive = false;
    }
  }

  Rectangle boundingBox() {
    return new Rectangle((int) position.x - (int) size/2, (int) position.y - (int) size/2, (int) size, (int) size);
  }

  void drawBoundingBox(Rectangle r) {
    noFill();
    rect(r.x, r.y, r.width, r.height);
    fill(255);
  }

  void update() {
    drawProjectile();
    move();
    checkWalls();
  }
}
