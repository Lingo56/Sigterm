/********************************************* //<>// //<>// //<>//
 Level 1 enemy
 Melee charging enemy type
 *********************************************/
class Enemy1 extends Enemy {

  Enemy1(PVector spawnPosition) {
    super(spawnPosition);
    charWidth = 30;
    charHeight = charWidth;
    enemyScale = 0; // Start hidden
    moveSpeed = 4;

    enemyColor = color(random(30, 230), random(200, 255), random(30, 230));
  }

  void update() {
    super.update();

    followPlayer();
  }

  void drawCharacter () {
    fill(enemyColor);
    strokeWeight(6);

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

    stroke(0, 0, 0);
    square(0, 0, charHeight);
    popMatrix();

    if (health > 0) {
      drawHealthBar();
    }

    ellipse(position.x, position.y, 3, 3);
  }

  void followPlayer() {
    PVector playerDirection = PVector.fromAngle(atan2(player.position.y - position.y, player.position.x - position.x));

    velocity = playerDirection.mult(moveSpeed);
  }
}

/*********************************************
 Level 1 boss, derrived from the level 1 enemy type
 *********************************************/
class Boss1 extends Enemy1 {
  // Constructor
  Boss1(PVector spawnPosition) {
    super(spawnPosition);

    health = 350;
    maxHealth = health;
    charWidth = 125;
    charHeight = 125;

    moveSpeed = 1;

    deathLength = 3000;
  }

  void kill() {
    super.kill();

    bossSpawned = false;
  }

  void update() {
    super.update();

    if (!dead) {
      checkProjectiles();
      fire();
    }
  }
}
