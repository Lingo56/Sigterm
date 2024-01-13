/*
Enemy superclass, every enemy is derrived from here
 */
class Enemy extends MyCharacter {
  ArrayList<Projectile> enemyProjectiles = new ArrayList<Projectile>();

  // Enemy Properties
  color enemyColor;
  long creationTimer;
  long playerImmunityTimer = 0;
  int playerImmunityLength;
  float enemyScale = 1;
  float moveSpeed;

  boolean isStunned;
  long stunStartTime = 0;

  boolean readyToClear = false;
  boolean dead = false;
  float deathScale = 0;
  long deathTimer = 0;
  int deathLength;

  // Projectile Properties
  float bulletSpawnPeriod = 1200;
  long bulletSpawnTime = millis();
  float bulletSpeed = 12;

  // Constructor
  Enemy(PVector spawnPosition) {
    position = spawnPosition;
    charWidth = 15;
    charHeight = charWidth;
    velocity.x = 0;
    velocity.y = 0;

    enemyColor = color(1, 1, 1);
    creationTimer = millis();
    playerImmunityLength = 1000;
    moveSpeed = 1;

    isStunned = false;

    deathLength = 1000;
  }

  // Update enemy state
  void update() {
    // Check if the enemy has been created less than 1 second ago.
    if (!dead && (millis() - creationTimer) < 1000) {
      return; // Do nothing if timer hasn't finished
    }

    if (!dead && !isStunned) moveCharacter();
    checkWalls();

    if (health <= 0 && !dead) {
      health = 0;
      kill();
    }

    if ((millis() - playerImmunityTimer) > playerImmunityLength && detectHit(player) && !dead) {
      playerImmunityTimer = millis();
      player.decreaseHealth(10);
    }

    if (isStunned) {
      if ((millis() - stunStartTime) >= 2000) {
        isStunned = false;
      }
    }
  }

  // Draw placeholder enemy character
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
    }

    stroke(0, 0, 0);
    fill(enemyColor);
    ellipse(0, 0, charHeight, charWidth);
    popMatrix();

    drawHealthBar();

    ellipse(position.x, position.y, 3, 3);
  }

  // Draw health bar
  void drawHealthBar() {
    pushMatrix();
    translate(position.x, position.y);

    fill(255);
    float healthValue = map(health, 0, maxHealth, 0, charWidth);

    rect(0, charHeight + 11, healthValue, 4);
    popMatrix();
  }

  // Handle enemy death
  void kill() {
    deathTimer = millis();
    dead = true;
  }

  // Check collisions with walls
  void checkWalls() {
    // Test to see if the shape exceeds the boundaries of the screen
    // If it does, reverse its direction by multiplying by -1
    if (position.x > width-charWidth || position.x < charWidth) {
      velocity.x *= -1;
    }
    if (position.y > height-charHeight || position.y < charHeight) {
      velocity.y *= -1;
    }
  }

  // An updated bounding box that's a bit larger for more forgiving collison
  Rectangle boundingBox() {
    int boxWidth = (int) charWidth + 50;
    int boxHeight = (int) charHeight + 50;

    return new Rectangle((int) position.x - boxWidth/2, (int) position.y - boxHeight/2, boxWidth, boxHeight);
  }

  // Handle projectile firing
  void fire() {
    if ((millis() - bulletSpawnTime) > bulletSpawnPeriod) {
      bulletSpawnTime = millis();

      PVector aimDirection = PVector.fromAngle(atan2(player.position.y - position.y, player.position.x - position.x));
      enemyProjectiles.add(new Projectile(new PVector(position.x, position.y), aimDirection.mult(bulletSpeed), 20, 40, enemyColor));
    }
  }

  // Handle projectile collisions
  void checkProjectiles() {
    for (int i=0; i < enemyProjectiles.size(); i++) {
      Projectile p = enemyProjectiles.get(i);
      p.update();

      p.hit(player);

      if (!p.isAlive) enemyProjectiles.remove(i);
    }
  }
}

// Allows for different spawn settings for each enemy type
class EnemySpawnSettings {
  long spawnTimer;
  int spawnFrequency;
  int maxEnemies;

  EnemySpawnSettings(int spawnFrequency, int maxEnemies) {
    this.spawnFrequency = spawnFrequency;
    this.spawnTimer = 0;
    this.maxEnemies = maxEnemies;
  }
}
