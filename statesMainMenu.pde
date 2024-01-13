void mainMenu() {
  background(0);
  pauseStartTime = 0;

  image(uiImageControl.mainMenuImage, width/2-uiImageControl.mainMenuImage.width/2, height/2-uiImageControl.mainMenuImage.height/2);

  menuButtonL.setLabel("Start");
  menuButtonR.setLabel("Info");

  xpBar.hide();
  healthBar.hide();

  cp5.draw();
}

void menuInfo() {
  background(0);
  image(uiImageControl.infoMenuImage, width/2-uiImageControl.infoMenuImage.width/2, height/2-uiImageControl.infoMenuImage.height/2);
  menuButtonL.setLabel("Start");
  menuButtonR.setLabel("Title");

  cp5.draw();
}

void deathCard () {
  uiImageControl.endTitleAlpha = lerp(uiImageControl.endTitleAlpha, 255, 0.05);
  
  drawBackground();
  
  tint(255,uiImageControl.endTitleAlpha);
  image(uiImageControl.deathTitleImage, width/2-uiImageControl.deathTitleImage.width/2, height/2-uiImageControl.deathTitleImage.height/2);
  player.drawCharacter();
}

void endCard () {
  handleWinMusic();
  
  uiImageControl.endTitleAlpha = lerp(uiImageControl.endTitleAlpha, 255, 0.005);
  
  drawBackground();
  
  tint(255,uiImageControl.endTitleAlpha);
  image(uiImageControl.endTitleImage, width/2-uiImageControl.endTitleImage.width/2, height/2-uiImageControl.endTitleImage.height/2);
  player.drawCharacter();
}

void play() {
  if (menuButtonL != null) {
    pauseEndTime = millis();
    handlePauseTime();
    state = LEVEL_ONE;

    menuButtonL.hide();
    menuButtonR.hide();

    xpBar.show();
    healthBar.show();
  }
}

void secondary() {
  if (menuButtonR != null) {
    if (state == MENU_MAIN) {

      state = MENU_INFO;
    } else {
      state = MENU_MAIN;
    }
  }
}
