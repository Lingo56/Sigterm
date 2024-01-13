/*********************************************
 Final boss, heavily modified Enemy 3
 *********************************************/
class Boss4 extends Enemy3 {
  ArrayList<Projectile> bossProjectiles = new ArrayList<Projectile>();
  float bulletSpawnPeriod = 1200;
  long bulletSpawnTime = 0;

  Boss4(PVector spawnPosition) {
    super(spawnPosition);
    charWidth = 125;
    charHeight = 125;
    enemyColor = color(255);
    enemyScale = 0;
    velocity.x = random(-5, 5);
    velocity.y = random(-5, 5);

    health = 4000;
    maxHealth = health;

    bulletSpawnPeriod = 20000; // Make bullet firing rare

    health = 1200;
    maxHealth = health;

    deathLength = 3000;
  }

  void update() {
    super.update();

    if (!dead) {
      checkProjectiles();
      fire();
    }
  }

  void drawCharacter () {
    pushMatrix();
    translate(position.x, position.y);

    if (dead) {
      if ((millis() - deathTimer) > deathLength) {
        enemyScale = lerp(enemyScale, deathScale, 0.1);
        scale(enemyScale);
      }

      if ((millis() - deathTimer) > deathLength + 500) {
        readyToClear = true;
      }
    } else {
      if (enemyScale < 1.0) {
        enemyScale = lerp(enemyScale, 1.0, 0.1);
        scale(enemyScale);
      }
    }

    strokeWeight(6);
    stroke(0, 0, 0);

    fill(enemyColor);
    quad(0, charHeight,
      charWidth/1.25, 0,
      0, -charHeight,
      -charWidth/1.25, 0);

    ellipse(0, 0, 3, 3);

    popMatrix();

    if (health > 0) {
      drawHealthBar();
    }
  }

  void kill() {
    super.kill();

    state = WIN;
  }
}
