int upgradeState = 1;

void upgrade() {
  drawBackground();
  player.drawCharacter();

  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).drawCharacter();
  }

  fill(10);
  rect(width/2, height/2, 500, 300);

  cp5.draw();

  translate(-uiImageControl.orbRed.width/2, -uiImageControl.orbRed.height/2); // Can cheat with this since each orb has same dimensions
  image(uiImageControl.orbBlue, width/2 - 300, height/2 - 20);
  image(uiImageControl.orbRed, width/2, height/2 - 20);
  image(uiImageControl.orbYellow, width/2 + 300, height/2 - 20);

  uiImageControl.updateFrames();

  upgradeButtonL.show();
  upgradeButtonM.show();
  upgradeButtonR.show();
}

// Reacts to upgrade1 button
void applyUpgrade1() {
  if (player.upgradeEffect != null && state != 0) {
    switch(upgradeState) {
    case 1:
      player.upgradeEffect.increaseFireRate();
      break;
    case 2:
      player.upgradeEffect.doubleDamage();
      break;
    case 3:
      player.upgradeEffect.damageBoostWhenNotMoving();
      break;
    }
  }
}

// Reacts to upgrade2 button
void applyUpgrade2() {
  if (player.upgradeEffect != null && state != 0) {
    switch(upgradeState) {
    case 1:
      player.upgradeEffect.increasePlayerSpeed();
      break;
    case 2:
      player.upgradeEffect.stun();
      break;
    case 3:
      player.upgradeEffect.maxHealthIncrease();
      break;
    }
  }
}

// Reacts to upgrade3 button
void applyUpgrade3() {
  if (player.upgradeEffect != null && state != 0) {
    switch(upgradeState) {
    case 1:
      player.upgradeEffect.increaseBulletSpeed();
      break;
    case 2:
      player.upgradeEffect.reFire();
      break;
    case 3:
      player.upgradeEffect.healthLostBulletRate();
      break;
    }
  }
}

void updateUpgradeState(int newUpgradeState) {
  upgradeState = newUpgradeState;

  switch(upgradeState) {
  case 1:
    upgradeButtonL.setLabel("\n\n\n\n\n\nUpgrade Fire Rate");
    upgradeButtonM.setLabel("\n\n\n\n\n\nUpgrade Move Speed");
    upgradeButtonR.setLabel("\n\n\n\n\n\nUpgrade Bullet Speed");
    break;
  case 2:
    upgradeButtonL.setLabel("\n\n\n\n\n\n1.5x Bullet Damage, -25 Health \n                 (Cannot Kill)");
    upgradeButtonM.setLabel("\n\n\n\n\n\n+15% Chance to Stun Enemies on Hit");
    upgradeButtonR.setLabel("\n\n\n\n\n\n+15% Chance to Refire from Enemy Hit");
    break;
  case 3:
    upgradeButtonL.setLabel("\n\n\n\n\n\n+0.4x Damage while standing still");
    upgradeButtonM.setLabel("\n\n\n\n\n\n         +20 Total health \n(Doesn't Restore Health)");
    upgradeButtonR.setLabel("\n\n\n\n\n\nIncreased Firerate for each health point \n                                under total");
    break;
  }
}
