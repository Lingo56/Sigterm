import java.awt.Rectangle;
import controlP5.*;
import ddf.minim.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

final boolean DEBUG = true; // Enables certain hotkeys for quickly moving between states

final int MENU_MAIN = 0;
final int MENU_INFO = 1;
final int PAUSE = 10;
final int LEVEL_ONE = 101;
final int LEVEL_TWO = 102;
final int LEVEL_THREE = 103;
final int LEVEL_FINAL = 104;
final int UPGRADE_SCREEN = 200;
final int GAME_OVER = 300;
final int WIN = 301;

int state;

PFont font;

void setup() {
  size (1600, 900, P2D);

  initGameResources();
}

void draw() {
  surface.setTitle("Sigterm " + String.format("%.1f", frameRate)); // Shows framerate in titlebar

  switch(state) {
  case MENU_MAIN:
    mainMenu();
    break;
  case MENU_INFO:
    menuInfo();
    break;
  case PAUSE:
    pause();
    break;
  case LEVEL_ONE:
    levelOne();
    break;
  case LEVEL_TWO:
    levelTwo();
    break;
  case LEVEL_THREE:
    levelThree();
    break;
  case LEVEL_FINAL:
    levelFinal();
    break;
  case UPGRADE_SCREEN:
    upgrade();
    break;
  case GAME_OVER:
    deathCard();
    break;
  case WIN:
    endCard();
    break;
  }
}

void initGameResources() {
  setupGame();
  setupBackground();
  setupGUI();
  setupAudio();

  state = MENU_MAIN;
}
