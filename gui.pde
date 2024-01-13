ControlP5 cp5;
Slider healthBar, xpBar;
Button menuButtonR, menuButtonL, upgradeButtonL, upgradeButtonM, upgradeButtonR;
InterfaceImageControl uiImageControl = new InterfaceImageControl();

void setupGUI() {
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  uiImageControl.loadMenuImages();

  uiImageControl.loadFrames(uiImageControl.orbBlueFrames, "./orbblue/SparklingOrb(Blue)");
  uiImageControl.loadFrames(uiImageControl.orbRedFrames, "./orbred/SparklingOrb(Red)");
  uiImageControl.loadFrames(uiImageControl.orbYellowFrames, "./orbyellow/SparklingOrb(Yellow)");

  uiImageControl.orbBlue = uiImageControl.orbBlueFrames[uiImageControl.currFrame];
  uiImageControl.orbRed = uiImageControl.orbRedFrames[uiImageControl.currFrame];
  uiImageControl.orbYellow = uiImageControl.orbYellowFrames[uiImageControl.currFrame];

  healthBar = cp5.addSlider("health")
    .setPosition(25, 825)
    .setRange(0, player.maxHealth)
    .setValue(0)
    .setSize(300, 50)
    .lock()
    .setColorForeground(color(150, 0, 0))
    .setColorBackground(color(200, 200, 200, 60))
    .setColorValue(color(255))
    ;

  xpBar = cp5.addSlider("xp")
    .setPosition(25, 815)
    .setRange(0, 100)
    .setValue(0)
    .setSize(300, 10)
    .lock()
    .setColorForeground(color(190, 120, 0))
    .setColorBackground(color(200, 200, 200, 60))
    .setColorValue(color(255))
    ;

  // create a new button with name 'start'
  menuButtonL = cp5.addButton("play")
    .setValue(0)
    .setPosition(width/2 - 300, height/2 + 200)
    .setSize(250, 100)
    .setColorBackground(color(35))
    .setColorForeground(color(55))
    .setColorActive(color(0))
    ;

  // create a new button with name 'secondary'
  menuButtonR = cp5.addButton("secondary")
    .setValue(0)
    .setPosition(width/2 + 50, height/2 + 200)
    .setSize(250, 100)
    .setColorBackground(color(35))
    .setColorForeground(color(55))
    .setColorActive(color(0))
    ;

  // create a new button with name 'applyUpgrade1'
  upgradeButtonL = cp5.addButton("applyUpgrade1")
    .setValue(0)
    .setPosition(width/2 - 400, height/2 - 250)
    .hide()
    .setSize(200, 500)
    .setColorBackground(color(35))
    .setColorForeground(color(55))
    .setColorActive(color(0))
    ;

  // create a new button with name 'applyUpgrade2'
  upgradeButtonM = cp5.addButton("applyUpgrade2")
    .setValue(0)
    .setPosition(width/2 - 100, height/2 - 250)
    .hide()
    .setSize(200, 500)
    .setColorBackground(color(35))
    .setColorForeground(color(55))
    .setColorActive(color(0))
    ;

  // create a new button with name 'applyUpgrade3'
  upgradeButtonR = cp5.addButton("applyUpgrade3")
    .setValue(0)
    .setPosition(width/2 + 200, height/2 - 250)
    .hide()
    .setSize(200, 500)
    .setColorBackground(color(35))
    .setColorForeground(color(55))
    .setColorActive(color(0))
    ;
}

void updateGUI() {
  healthBar.setValue(player.health);
  healthBar.setRange(0, player.maxHealth);
  xpBar.setValue(player.xp);
}

class InterfaceImageControl {
  PImage[] orbBlueFrames = new PImage[12];
  PImage[] orbRedFrames = new PImage[12];
  PImage[] orbYellowFrames = new PImage[12];

  PImage orbBlue;
  PImage orbRed;
  PImage orbYellow;

  int currFrame = 0;

  PImage mainMenuImage;
  PImage infoMenuImage;
  PImage deathTitleImage;
  PImage endTitleImage;

  float endTitleAlpha = 0;

  void loadMenuImages () {
    mainMenuImage = loadImage("title.png");
    infoMenuImage = loadImage("info.png");
    deathTitleImage = loadImage("deathcard.png");
    endTitleImage = loadImage("endcard.png");
  }

  void loadFrames(PImage[] ar, String fname) {
    for (int i=0; i<ar.length; i++) {
      int index = i + 1;
      PImage frame=loadImage(fname+index+".png");
      //frame.resize(100, 100);
      ar[i]=frame;
    }
  }

  void updateFrames() {
    if (frameCount % 5 == 0) { //Display each image for 2 frames before switching to the next
      // Since every orb uses the same number of frames you can cheat here
      if (currFrame < orbBlueFrames.length-1) //if within array length
        currFrame++;                        //switch to the next image
      else
        currFrame = 0; //if reaching the end of the array restart from the begining

      orbBlue = orbBlueFrames[currFrame];
      orbRed = orbRedFrames[currFrame];
      orbYellow = orbYellowFrames[currFrame];
    }
  }
}
