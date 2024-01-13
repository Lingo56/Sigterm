class Player extends MyCharacter {
  // Player Properties
  float accAmount = 3;
  float damp = 0.81;
  float prevHealth = maxHealth;
  int xp;
  Upgrade upgradeEffect;

  // Projectile Properties
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  int bulletDamage = 50;
  int bulletSize = 10;
  float bulletSpeed = 9;
  float refireChance = 0;
  float stunChance = 0;

  float bulletFireRate = 1200;
  float healthDecreaseMultiplier = 0;
  float bulletFireRateMultiplier = 1;
  float standStillMultiplier = 1;
  long bulletTimer = 0;

  Player(PVector spawnPoint) {
    position = spawnPoint;
    charWidth = 35;
    charHeight = 100;
    maxVel = 4.75;
    xp = 0;

    maxHealth = 100;
    health = maxHealth;

    upgradeEffect = new Upgrade();
  }

  void update() {
    super.update();
    velocity.mult(damp);
    handleInput();
    checkProjectiles();

    bulletSize = bulletDamage/6;

    println(maxHealth);
    println(bulletFireRate);
    // Calculate the adjusted fire rate based on health and healthDecreaseMultiplier
    float adjustedFireRate = bulletFireRate * (1 - healthDecreaseMultiplier * (maxHealth - health) / maxHealth);
    println(adjustedFireRate);

    if ((millis() - bulletTimer) > adjustedFireRate) {
      fire(this);
    }
  }

  void drawCharacter() {
    pushMatrix();
    drawBody();
    popMatrix();
  }

  void drawBody() {
    strokeWeight(6);
    stroke(0);

    pushMatrix();
    translate(position.x, position.y);

    noFill();
    ellipse(0, 0, 7.5, 7.5);
    fill(0);
    drawHead();
    drawArms();
    drawLegs();

    popMatrix();
  }

  void drawHead() {
    line(0, -7.5, 0, -15);
    quad(0, -15,
      15, -32.5,
      0, -50,
      -15, -32.5);
  }

  void drawArms() {
    line(7.5, 0, 12.5, 2.5);
    line(12.5, 2.5, 17.5, 15);
    line(-7.5, 0, -12.5, 2.5);
    line(-12.5, 2.5, -17.5, 15);
  }

  void drawLegs() {
    line(0, 7.5, 0, 20);
    line(0, 20, 12.5, 37.5);
    line(12.5, 37.5, 12.5, 50);
    line(0, 20, -12.5, 37.5);
    line(-12.5, 37.5, -12.5, 50);
  }

  void handleInput() {
    PVector movement = new PVector(0, 0);

    if (NORTH) movement.add(0, -accAmount);
    if (SOUTH) movement.add(0, accAmount);
    if (WEST) movement.add(-accAmount, 0);
    if (EAST) movement.add(accAmount, 0);

    accelerate(movement);
  }

  void fire(MyCharacter c) {
    if (enemies.size() > 0) {
      Enemy nearestEnemy = findNearestEnemy(c);

      PVector aimDirection = PVector.fromAngle(atan2(nearestEnemy.position.y - c.position.y, nearestEnemy.position.x - c.position.x));

      // Check if the player is standing still
      if (velocity.mag() <= 0.1) {
        projectiles.add(new Projectile(new PVector(c.position.x, c.position.y), aimDirection.mult(bulletSpeed), bulletSize, bulletDamage * standStillMultiplier, color(255))); // Multiply bulletDamage by 5
      } else {
        projectiles.add(new Projectile(new PVector(c.position.x, c.position.y), aimDirection.mult(bulletSpeed), bulletSize, bulletDamage, color(255)));
      }
    }

    bulletTimer = millis();
  }

  Enemy findNearestEnemy(MyCharacter c) {
    Enemy nearestEnemy = enemies.get(0);
    float closestDistance = 5000;

    for (Enemy enemy : enemies) {
      float distance = player.position.dist(enemy.position);

      if (distance < closestDistance && !enemy.dead && enemy != c) {
        nearestEnemy = enemy;
        closestDistance = distance;
      }
    }

    return nearestEnemy;
  }

  Rectangle boundingBox() {
    int boxWidth = (int) charWidth - 30;
    int boxHeight = (int) charHeight - 30;

    return new Rectangle((int) position.x - boxWidth / 2, (int) position.y - boxHeight / 2, boxWidth, boxHeight);
  }

  void checkProjectiles() {
    for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile p = projectiles.get(i);
      p.update();

      for (Enemy e : enemies) {
        if (p.hit(e)) {
          checkBulletEffects(e);
        }
      }

      if (!p.isAlive) projectiles.remove(i);
    }
  }

  void checkBulletEffects(Enemy e) {
    if (random(0, 1) < stunChance) {
      e.isStunned = true;
      e.stunStartTime = millis();
    }

    if (random(0, 1) < refireChance) {
      fire(e);
    }
  }
}
