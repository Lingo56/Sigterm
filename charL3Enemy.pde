/*********************************************
 Level 3 enemy
 Random movement enemy type
 *********************************************/
class Enemy3 extends Enemy {
  Enemy3(PVector spawnPosition) {
    super(spawnPosition);
    charWidth = 45;
    charHeight = charWidth;
    enemyColor = color(random(190, 230), random(200, 250), random(0, 60));
    enemyScale = 0;
    velocity.x = -2;
    velocity.y = 2;

    moveSpeed = 4;

    health = 200;
    maxHealth = health;

    bulletSpawnPeriod = 10000; // Make bullet firing rare
    bulletSpeed = 5;
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
    triangle(-charWidth, charHeight, 0, -charHeight, charWidth, charHeight);
    ellipse(0, 0, 3, 3);

    popMatrix();

    if (health > 0) {
      drawHealthBar();
    }
  }

  void checkWalls() {
    if (position.x < -charWidth) position.x = width+charWidth;
    if (position.y < -charHeight) position.y = height+charHeight;
    if (position.x > width+charWidth) position.x = -charWidth;
    if (position.y > height+charHeight) position.y = -charHeight;
  }
}

// TODO make the boss change velocity randomly after a certain amount of time
class Boss3 extends Enemy3 {
  ArrayList<Projectile> bossProjectiles = new ArrayList<Projectile>();
  float bulletSpawnPeriod = 1200;
  long bulletSpawnTime = 0;

  Boss3(PVector spawnPosition) {
    super(spawnPosition);
    charWidth = 125;
    charHeight = 125;
    enemyScale = 0;

    health = 1000;
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

  void kill() {
    super.kill();
    bossSpawned = false;
  }
}
