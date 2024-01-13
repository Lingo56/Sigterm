/*********************************************
 Level 2 enemy
 Distraction oriented enemy type
 *********************************************/
class Enemy2 extends Enemy {
  float orbitDistance; // Distance from the player to orbit around
  float angularSpeed; // Speed at which the enemy moves around the player in radians per frame
  float angle; // Current angle for circular motion

  Enemy2(PVector spawnPosition) {
    super(spawnPosition);
    charWidth = 30;
    charHeight = charWidth;
    enemyColor = color(random(200, 230), random(30, 120), random(100, 150));
    enemyScale = 0;

    health = 300;
    maxHealth = health;

    bulletSpawnPeriod = 10000; // Make bullet firing rare

    orbitDistance = 210; // Adjust this value as needed
    angularSpeed = 0.27; // Adjust this value as needed
    angle = 0;
  }

  void update() {
    super.update();

    orbitPlayer();

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
    ellipse(0, 0, charWidth, charHeight);
    ellipse(0, 0, 3, 3);

    popMatrix();

    if (health > 0) {
      drawHealthBar();
    }
  }

  void orbitPlayer() {
    PVector directionToPlayer = PVector.sub(player.position, position);
    float distanceToPlayer = directionToPlayer.mag();

    if (distanceToPlayer > orbitDistance) {
      PVector playerDirection = PVector.fromAngle(atan2(player.position.y - position.y, player.position.x - position.x));

      velocity = playerDirection.mult(8.5);
    } else {
      // Calculate the initial angle for circular motion around the player
      float initialAngle = atan2(position.y - player.position.y, position.x - player.position.x);

      // Calculate the current angle for circular motion
      angle = (initialAngle + angularSpeed) % (TWO_PI);

      // Calculate the new position for circular motion around the orbit distance
      float targetX = player.position.x + orbitDistance * cos(angle);
      float targetY = player.position.y + orbitDistance * sin(angle);

      // Smoothly move towards the target position
      float smoothingFactor = 0.1;
      position.x = lerp(position.x, targetX, smoothingFactor);
      position.y = lerp(position.y, targetY, smoothingFactor);

      // Check for overlapping with other enemies
      // Avoid clumping with other enemies
      float minSeparation = charWidth * 1.5; // Adjust this value to control minimum separation
      float maxAvoidanceSpeed = 4; // Adjust this value to control the maximum avoidance speed

      for (Enemy otherEnemy : enemies) { // Use the Enemy type here
        if (otherEnemy != this && otherEnemy instanceof Enemy2) {
          Enemy2 otherEnemy2 = (Enemy2) otherEnemy;
          PVector awayFromOther = PVector.sub(position, otherEnemy2.position);
          float distanceToOther = awayFromOther.mag();

          if (distanceToOther < minSeparation) {
            // Calculate the avoidance speed based on the distance to the other enemy
            float avoidanceSpeed = maxAvoidanceSpeed * (1 - distanceToOther / minSeparation);

            // Move away from the other enemy at a limited avoidance speed
            awayFromOther.normalize();
            awayFromOther.mult(avoidanceSpeed);
            position.add(awayFromOther);

            // Update the angle to avoid getting stuck in a position
            angle += angularSpeed * 2;
          }
        }
      }

      // Set the velocity towards the target position
      PVector direction = PVector.sub(player.position, position);
      direction.normalize();
      velocity = direction.mult(4); // Adjust the velocity factor as needed
    }
  }
  
  // Handle projectile firing
  void fire() {
    if ((millis() - bulletSpawnTime) > bulletSpawnPeriod) {
      bulletSpawnTime = millis();

      PVector aimDirection = PVector.fromAngle(atan2(player.position.y - position.y, player.position.x - position.x));
      enemyProjectiles.add(new Projectile(new PVector(position.x, position.y), aimDirection.mult(2), 20, 20, enemyColor));
    }
  }
}

/*********************************************
 Level 2 boss, derrived from level 2 enemy type
 *********************************************/
class Boss2 extends Enemy2 {
  ArrayList<Projectile> bossProjectiles = new ArrayList<Projectile>();
  float bulletSpawnPeriod = 1200;
  long bulletSpawnTime = 0;

  Boss2(PVector spawnPosition) {
    super(spawnPosition);
    charWidth = 125;
    charHeight = 125;
    enemyColor = color(random(200, 230), random(30, 120), random(100, 150));
    enemyScale = 0;

    health = 300;
    maxHealth = health;

    bulletSpawnPeriod = 20000; // Make bullet firing rare

    orbitDistance = 400; // Adjust this value as needed
    angularSpeed = 0.1; // Adjust this value as needed
    angle = 0;

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
