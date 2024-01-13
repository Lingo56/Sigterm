void spawnEnemies() { //<>//
  int currentEnemyType = 0; // Initialize the counter for enemy types

  for (int i = 0; i < enemySpawnSettings.size(); i++) {
    int enemyType = currentEnemyType % enemySpawnSettings.size();
    EnemySpawnSettings enemySpawnSetting = enemySpawnSettings.get(enemyType);

    if ((millis() - enemySpawnSetting.spawnTimer > enemySpawnSetting.spawnFrequency) && (enemies.size() < enemySpawnSetting.maxEnemies)) {
      float xSpawn, ySpawn;
      boolean validSpawn = false;

      // Loop until a valid spawn point is found (not within 150 units of the player)
      while (!validSpawn) {
        xSpawn = random(0, width - 100);
        ySpawn = random(50, height - 100);
        PVector enemySpawnPoint = new PVector(xSpawn, ySpawn);

        // Calculate the distance between the player and the spawn point
        float distanceToPlayer = PVector.dist(player.position, enemySpawnPoint);

        // Check if the spawn point is at least 150 units away from the player
        if (distanceToPlayer >= 300) {
          validSpawn = true;
          
          spawnBoss();

          switch (enemyType) {
          case 0:
            spawnEnemy1(enemySpawnPoint);
            break;
          case 1:
            spawnEnemy2(enemySpawnPoint);
            break;
          case 2:
            spawnEnemy3(enemySpawnPoint);
            break;
          }
        }
      }
      enemySpawnSetting.spawnTimer = millis();
    }
    currentEnemyType++;
  }
}

void spawnEnemy1(PVector enemySpawnPoint) {
  enemies.add(new Enemy1(enemySpawnPoint));
}

void spawnEnemy2(PVector enemySpawnPoint) {
  if (state >= LEVEL_TWO) {
    enemies.add(new Enemy2(enemySpawnPoint));
  }
}

void spawnEnemy3(PVector enemySpawnPoint) {
  if (state >= LEVEL_THREE) {
    enemies.add(new Enemy3(enemySpawnPoint));
  }
}

void spawnBoss() {  
  // Check if it's time to spawn the boss
  if (!bossSpawned && state != UPGRADE_SCREEN) {
    switch (state) {
    case LEVEL_ONE:
      spawnBoss1();
      break;
    case LEVEL_TWO:
      spawnBoss2();
      break;
    case LEVEL_THREE:
      spawnBoss3();
      break;
    case LEVEL_FINAL:
      spawnBoss4();
      break;
    }
  }
}

void spawnBoss1() {
  if (millis() - bossSpawnTime > boss1Spawn) {
    enemies.add(new Boss1(new PVector(width/2, 200)));
    bossSpawned = true;
    bossSpawnTime = millis();
  }
}

void spawnBoss2() {
  println("boss 2 checked");
  if (millis() - bossSpawnTime > boss2Spawn) {
    println("Boss 2 spawned");
    enemies.add(new Boss2(new PVector(width/2, 200)));
    bossSpawned = true;
    bossSpawnTime = millis();
  }
}

void spawnBoss3() {
  println(bossSpawnTime);
  if (millis() - bossSpawnTime > boss3Spawn) {
    enemies.add(new Boss3(new PVector(width/2, 200)));
    bossSpawned = true;
    bossSpawnTime = millis();
  }
}

void spawnBoss4() {
  if (!finalBossSpawned) {
    enemies.add(new Boss4(new PVector(width/2, 200)));
    finalBossSpawned = true;
  }
}

void updateEnemies() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).update();
    enemies.get(i).drawCharacter();

    if (enemies.get(i).readyToClear) {
      enemies.remove(i);
      player.xp += 10;
    }
  }
}
