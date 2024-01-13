/*
Player upgrade class
 Holds all the logic related to modifying player stats when upgrading
 */
class Upgrade {

  // Level One Upgrades

  void increaseBulletSpeed() {
    if (player.bulletSpeed < 15) {

      player.bulletSpeed += 2;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonR.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  void increaseFireRate() {
    if (player.bulletFireRate > 500) {

      player.bulletFireRate -= 350;

      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonL.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  void increasePlayerSpeed() {
    if (player.maxVel < 6.0) {

      player.maxVel += 0.4;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonM.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  // Level Two Upgrades

  void reFire() {
    if (player.refireChance < 0.45) {
      player.refireChance += 0.15;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonR.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  void stun() {
    if (player.stunChance < 0.45) {
      player.stunChance += 0.15;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonM.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  void doubleDamage() {
    if (player.bulletDamage < 200) {
      player.bulletDamage *= 1.5;
      player.xp = 0;

      if (player.health - 25 <= 0) {
        player.health = 1;
      } else {
        player.health -= 25;
      }

      handleButtons();
    } else {
      upgradeButtonL.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  // Level Three Upgrades

  void maxHealthIncrease() {
    if (player.maxHealth < 200) {
      player.maxHealth += 20;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonM.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  void healthLostBulletRate() {
    if (player.healthDecreaseMultiplier < 0.35) {
      player.healthDecreaseMultiplier += 0.08;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonR.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  void damageBoostWhenNotMoving() {
    if (player.standStillMultiplier < 1.8) {
      player.standStillMultiplier += 0.4;
      player.xp = 0;

      handleButtons();
    } else {
      upgradeButtonL.setLabel("\n\n\n\n\n\nMaxed");
    }
  }

  // Utility
  void handleButtons() {
    if (upgradeButtonL != null && upgradeButtonM != null && upgradeButtonR != null) {
      state = prevState;

      upgradeButtonL.hide();
      upgradeButtonM.hide();
      upgradeButtonR.hide();

      pauseEndTime = millis();
      handlePauseTime();
    }
  }
}
