void pause() { //<>//
  player.drawCharacter();

  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).drawCharacter();
  }
}

void levelOne() {
  targetStartClr = new float[] { 0, 1, 0.4, 1.0 };
  targetStopClr = new float[] { 0, 0.3, 0.8, 1.0 };

  playMusic(0); // Play level one music (index 0)
  updateUpgradeState(1);

  gameUpdate();
  checkLevelTransition();
}

void levelTwo() {
  targetStartClr = new float[] { 1, 0, 0, 1.0 };
  targetStopClr = new float[] { 0.3, 0, 0, 1.0 };

  playMusic(1); // Play level two music (index 1)
  updateUpgradeState(2);

  gameUpdate();
  checkLevelTransition();
}

void levelThree() {
  targetStartClr = new float[] { 1, 0.84, 0, 1.0 };
  targetStopClr = new float[] { 1, 0.27, 0, 1.0 };

  playMusic(2); // Play level three music (index 2)
  updateUpgradeState(3);

  gameUpdate();
  checkLevelTransition();
}


void levelFinal() {
  targetStartClr = new float[] { 1, 1, 1, 1.0 };
  targetStopClr = new float[] { 0.9, 0.9, 0.9, 1.0 };

  playMusic(3); // Play level final music (index 3)

  gameUpdate();
}
