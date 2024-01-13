long enemySpawnTime = 0;
long bossSpawnTime = 0;
long levelTimer = 0;
int enemySpawnFreq = 2000;
int maxEnemies = 12;
boolean bossSpawned = false;
boolean finalBossSpawned = false;

// Game event timings
long levelChangeTime = 60000; //120000
long boss1Spawn = 40000; // 95000
long boss2Spawn = 30000; // 215000
long boss3Spawn = 50000; // 330000

// For adding this amounf of time to event timings whenever the game is in a paused state
long pauseStartTime = 0;
long pauseEndTime = 0;

int prevState = 0;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<EnemySpawnSettings> enemySpawnSettings = new ArrayList<EnemySpawnSettings>();
Player player;

void setupGame() {
  player = new Player(new PVector(width/2, height/2));

  // Initialize enemy spawn settings (ms to spawn, max total of type)
  enemySpawnSettings.add(new EnemySpawnSettings(2000, 25)); // Enemy1 settings
  enemySpawnSettings.add(new EnemySpawnSettings(4500, 7)); // Enemy2 settings
  enemySpawnSettings.add(new EnemySpawnSettings(4500, 15)); // Enemy3 settings
}

void gameUpdate() {
  drawBackground();
  updateGUI();

  player.drawCharacter();
  player.update();

  spawnEnemies();
  updateEnemies();

  cp5.draw();

  if (player.health <= 0) {
    state = GAME_OVER;
  }

  if (player.xp >= 100 && state == LEVEL_FINAL) {
    if (player.health < player.maxHealth) {
      player.xp = 0;
      player.health += 10;
    }
    
    return;
  }

  if (player.xp >= 100 && state != UPGRADE_SCREEN && state != PAUSE) {
    prevState = state;
    state = UPGRADE_SCREEN;
    pauseStartTime = millis();
  } 
}

void handlePause() {
  if (state == MENU_MAIN) {
    return;
  }

  if (state != PAUSE) {
    pauseStartTime = millis();
    prevState = state;
    state = PAUSE;
  } else {
    state = prevState;
    pauseEndTime = millis();
    handlePauseTime();
  }
}

void checkLevelTransition() {
  if (millis() - levelTimer > levelChangeTime) {
    state = state + 1;
    levelTimer = millis();
  }
}

void handlePauseTime() {
  long timePaused = pauseEndTime - pauseStartTime;
  
  levelChangeTime += timePaused;
  bossSpawnTime += timePaused;

  for (Enemy e : enemies) {
    e.bulletSpawnTime += timePaused;
  }
}
